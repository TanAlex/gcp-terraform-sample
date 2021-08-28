data "terraform_remote_state" "network" {
  backend = "gcs"
  // workspace = "${terraform.workspace}"

  config {
    project = var.project
    bucket  = var.bucket_name
    prefix  = var.prefix
  }
}