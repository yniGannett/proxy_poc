variable "fastly_name" {
  type = "string"
  default = "api-proxy"
}

variable "SUMO_COLLECTOR" {
  type = "string"
}

resource "fastly_service_v1" "fastly" {
    name = "${terraform.workspace == "production" ? var.fastly_name : format("%s-%s", terraform.workspace, var.fastly_name)}"
    backend {
        name = "argon"
        address = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        port = 443
        use_ssl = true
        ssl_check_cert = true
        ssl_sni_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        ssl_cert_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        healthcheck = "argon"
    }
    healthcheck {
        name = "argon"
        host = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        path = "/status"
        expected_response = 200
        method = "GET"
        check_interval = 60000
        threshold = 1
        timeout = 5000
        window = 2
        initial = 1
    }
    backend {
        name = "argon-west"
        address = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        port = 443
        use_ssl = true
        ssl_check_cert = true
        ssl_sni_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        ssl_cert_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        healthcheck = "argon-west"
    }
    healthcheck {
        name = "argon-west"
        host = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        path = "/status"
        expected_response = 200
        method = "GET"
        check_interval = 60000
        threshold = 1
        timeout = 5000
        window = 2
        initial = 1
    }
    backend {
        name = "thorium"
        address = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        port = 443
        use_ssl = true
        ssl_check_cert = true
        ssl_sni_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        ssl_cert_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        healthcheck = "thorium"
    }
    healthcheck {
        name = "thorium"
        host = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-east.production.gannettdigital.com"}"
        path = "/status"
        expected_response = 200
        method = "GET"
        check_interval = 60000
        threshold = 1
        timeout = 5000
        window = 2
        initial = 1
    }
    backend {
        name = "thorium-west"
        address = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        port = 443
        use_ssl = true
        ssl_check_cert = true
        ssl_sni_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        ssl_cert_hostname = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        healthcheck = "thorium-west"
    }
    healthcheck {
        name = "thorium-west"
        host = "${terraform.workspace == "origin-staging" ? "thorium-east.staging.gannettdigital.com" : "thorium-west.production.gannettdigital.com"}"
        path = "/status"
        expected_response = 200
        method = "GET"
        check_interval = 60000
        threshold = 1
        timeout = 5000
        window = 2
        initial = 1
    }      
}