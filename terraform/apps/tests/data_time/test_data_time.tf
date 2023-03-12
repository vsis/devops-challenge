terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    http = {
      source = "hashicorp/http"
    }
  }
}

module main {
  source = "../.."
}

resource "test_assertions" "time_api_response" {
  component = "time_api_response"

  check "valid_json" {
    description = "Time URL responds with valid JSON"
    condition   = can(jsondecode(module.main.time_api))
  }
}
