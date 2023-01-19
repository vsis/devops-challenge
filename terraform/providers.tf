terraform {
  required_providers {
    random      = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    google      = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
    kubernetes  = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    helm        = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
    http        = {
      source  = "hashicorp/http"
    }
  }
}

provider "google" {
    region  = "europe-southwest1"
}

data "google_client_config" "default" {}

provider "kubernetes" {
    host                      = "https://${google_container_cluster.cluster.endpoint}"
    token                     = data.google_client_config.default.access_token
    cluster_ca_certificate    = base64decode(
        google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
    )
}

provider "helm" {
    kubernetes {
        host                      = "https://${google_container_cluster.cluster.endpoint}"
        token                     = data.google_client_config.default.access_token
        cluster_ca_certificate    = base64decode(
            google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
        )
    }
}

provider "http" {}