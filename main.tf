resource "google_storage_bucket" "bucket" {
  name = "test-bucket-random-0012345"
  location = var.region
}

resource "google_storage_bucket" "gcs_bucket" {
  name = "test-bucket-random-0064224"
  location = var.region
}
