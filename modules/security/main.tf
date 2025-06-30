# Get the VPC network
data "google_compute_network" "vpc" {
    name = var.vpc_name
}

# Allow SSH only from specific IP to frontend VMs
resource "google_compute_firewall" "allow_ssh" {
    name    = "allow-ssh-frontend"
    network = data.google_compute_network.vpc.self_link

    direction = "INGRESS"
    priority  = 1000

    source_ranges = var.allowed_ssh_source_ranges
    target_tags   = ["frontend"]

    allow {
        protocol = "tcp"
        ports     = ["22"]
    }
}

# Allow HTTP/HTTPS to frontend only 
resource "google_compute_firewall" "allow_http_https" {
    name    = "allow-http-https"
    network = data.google_compute_network.vpc.self_link

    direction     = "INGRESS"
    priority      = 1000
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["frontend"]

    allow {
      protocol = "tcp"
      ports    = ["80", "443"]
    }
}

# Allow internal communication (app <-> DB <-> frontend)
resource "google_compute_firewall" "allow_internal" {
    name    = "allow-internal"
    network = data.google_compute_network.vpc.self_link

    direction     = "INGRESS"
    priority      = 1000
    source_ranges = ["10.10.0.0/16"]
    target_tags   = ["app", "db", "frontend"]

    allow {
        protocol = "all"
    }
}

resource "google_project_iam_binding" "ssh_admin" {
  role    = "roles/compute.instanceAdmin.v1"
  project = var.project_id

  members = [
    "user:ayush.gharat.btech2023@atlasskilltech.university",
    "user:ayushgharat234@gmail.com"
  ]
}
