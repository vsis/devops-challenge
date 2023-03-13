terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1" # Freeze this version
    }
  }

  # Added a cloud tfbackend here
  backend "gcs" {
    bucket = "dvn-test-tfstate"
    prefix = "idoven-devops-challenge-apps"
  }
}

provider "kubernetes" {
  # Avoid using gcloud module output as input for this provider
  # See: https://itnext.io/terraform-dont-use-kubernetes-provider-with-your-cluster-resource-d8ec5319d14a
  config_path = "~/.kube/config"
}

provider "helm" {
  # Avoid using gcloud module output as input for this provider
  # See: https://itnext.io/terraform-dont-use-kubernetes-provider-with-your-cluster-resource-d8ec5319d14a
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "http" {}
