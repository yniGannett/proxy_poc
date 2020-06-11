package main

import (
	"log"
	"os"
	"testing"

	fastly "github.com/GannettDigital/go-fastly-tests"
)

func TestMain(m *testing.M) {
	env, exists := os.LookupEnv("ENVIRONMENT")
	if !exists {
		log.Fatal("ENVIRONMENT must exist")
	}
	if env != "production" {
		err := fastly.Purge()
		if err != nil {
			log.Fatal(err)
		}
	}
	exitCode := m.Run()
	os.Exit(exitCode)
}
