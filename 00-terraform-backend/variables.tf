variable "tags" {
  type        = map(string)
  default     = {}
  description = "Terraform resource tags -- useful for metadata and cost tracking"
}

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
  default     = "us-wes1"
  description = "GCP region"
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

variable "bucket_name" {
  type        = string
  description = "The name of the Google Storage Bucket to create"
}
variable "storage_class" {
  type        = string
  description = "The storage class of the Storage Bucket to create"
}