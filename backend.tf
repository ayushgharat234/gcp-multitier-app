terraform {
    backend "gcs" {
        bucket = "gcp-multitier-app-terraform-state"
        prefix = "terraform/state"
    }
}
