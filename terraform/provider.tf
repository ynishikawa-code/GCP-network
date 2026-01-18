provider "google" {
  credentials = file("~/.gcp/terraform-key.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}
