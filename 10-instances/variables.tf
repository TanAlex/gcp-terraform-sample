variable "environment" {
  type        = string
  default     = "dev"
  description = "Your environments like dev,qa,prod"
}

variable "project" {
  type        = string
  description = "Your project name for this environment"
}
variable "region" {
  type        = string
  default     = "us-west1"
  description = "GCP region"
}

variable "zone" {
  type        = string
  default     = "us-west1-b"
  description = "GCP zone"
}

# GCP authentication file
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
}

variable "gcp_token_file" {
  type        = string
  description = "GCP SA Token file"
}

# --------------------------------
# Variables
# --------------------------------

variable "vpc_name" {
  type        = string
  description = "name prefix for network and subnetwork"
}
