terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.79.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "3.79.0"
    }
    # kubernetes = {
    #   source = "hashicorp/kubernetes"
    #   version = "2.4.1"
    # }
    # helm = {
    #   source = "hashicorp/helm"
    #   version = "2.2.0"
    # }
  }
}
provider "google" {
  project      = var.project
  region       = var.region
  # zone         = var.zone
  access_token = trimspace(file(var.gcp_token_file))
  # credentials = file(var.gcp_auth_file)
}

provider "google-beta" {
  project      = var.project
  region       = var.region
  # zone         = var.zone
  access_token = trimspace(file(var.gcp_token_file))
  # credentials = file(var.gcp_auth_file)
}