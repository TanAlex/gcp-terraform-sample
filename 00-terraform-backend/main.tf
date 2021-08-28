# Create a GCS Bucket
resource "google_storage_bucket" "tf-bucket" {
  project       = var.project
  name          = var.bucket_name
  location      = var.region
  force_destroy = false
  storage_class = var.storage_class
  versioning {
    enabled = true
  }
}
