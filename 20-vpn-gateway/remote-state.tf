data "terraform_remote_state" "network" {
  backend = "gcs"
  // workspace = "${terraform.workspace}"
  config = {
    bucket  = var.bucket_name
    prefix  = var.prefix
  }
}