provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "manoj-remote-tf-state"
    prefix = "terraform/state"
  }
}
