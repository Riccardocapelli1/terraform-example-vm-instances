#task3
provider "google" {
  project     = "qwiklabs-gcp-01-a89a911df98f"
  region      = "US"
}

resource "google_storage_bucket" "sample" {
  name        = "tf-bucket-846120"
  location    = "US-CENTRAL1"
  force_destroy = true
  uniform_bucket_level_access = true
}