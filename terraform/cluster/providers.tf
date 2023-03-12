terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
  }

  # Added a cloud tfbackend here
  backend "gcs" {
    bucket = "dvn-test-tfstate"
    prefix = "idoven-devops-challenge"
  }
}

provider "google" {
  region = "europe-southwest1"
}
