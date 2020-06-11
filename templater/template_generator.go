package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"html/template"
	"io/ioutil"
	"log"
	"os"
)

type Address struct {
	Prod    []string `json:"prod"`
	Staging []string `json:"staging"`
}

type HealthCheck struct {
	Path   string `json:"path"`
	Method string `json:"method"`
}

type Terraform struct {
	Name         string      `json:"name"`
	Address      Address     `json:"backend_address"`
	Loadbalancer bool        `json:"loadbalancer"`
	Port         int         `json:"port"`
	TLS          bool        `json:"tls"`
	Healthcheck  HealthCheck `json:"healthcheck"`
}

func main() {
	var terraforms []Terraform
	var terraform Terraform

	folders, err := ioutil.ReadDir("../proxy")
	if err != nil {
		log.Fatal(err)
	}

	for _, f := range folders {
		path := fmt.Sprintf("../proxy/%s/config.json", f.Name())
		configFile, err := ioutil.ReadFile(path)
		if err != nil {
			fmt.Println("has error in read")
		}

		err = json.Unmarshal(configFile, &terraform)
		if err != nil {
			fmt.Println("has error in Unmarshal")
		}
		terraforms = append(terraforms, terraform)
	}

	tmpl, err := template.ParseGlob("*.tmpl")
	if err != nil {
		fmt.Println(err)
	}
	// create service.tf
	serviceFile, err := os.Create("../service.tf")
	defer serviceFile.Close()

	w := bufio.NewWriter(serviceFile)
	tmpl.ExecuteTemplate(w, "service.tf.tmpl", terraforms)
	w.Flush()

	// create configs.vcl
	serviceFile, err = os.Create("../configs.vcl")
	defer serviceFile.Close()

	w = bufio.NewWriter(serviceFile)
	tmpl.ExecuteTemplate(w, "configs.vcl.tmpl", terraforms)
	w.Flush()

	// create configs_test.go
	serviceFile, err = os.Create("../configs_test.go")
	defer serviceFile.Close()

	w = bufio.NewWriter(serviceFile)
	tmpl.ExecuteTemplate(w, "configs_test.go.tmpl", terraforms)
	w.Flush()
}
