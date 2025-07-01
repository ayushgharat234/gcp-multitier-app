# Allow SSH only from specific IP to frontend VMs
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = var.vpc_self_link

  direction = "INGRESS"
  priority  = 1000

  source_ranges = var.allowed_ssh_source_ranges
  target_tags   = ["frontend", "app"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Allow HTTP/HTTPS to frontend only 
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = var.vpc_self_link

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
  network = var.vpc_self_link

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

# Allow Frontend -> App
resource "google_compute_firewall" "allow_frontend_to_app" {
  name    = "allow-frontend-to-app"
  network = var.vpc_self_link

  allow {
    protocol = "tcp"
    ports    = [var.app_port]
  }

  source_tags = var.allowed_frontend_to_app
  target_tags = ["app"]
  direction   = "INGRESS"
}

# Allow App -> DB
resource "google_compute_firewall" "allow_app_to_db" {
  name    = "allow-app-to-db"
  network = var.vpc_self_link

  allow {
    protocol = "tcp"
    ports    = [var.db_port]
  }

  source_tags = var.allowed_app_to_db
  target_tags = ["db"]
  direction   = "INGRESS"
}

resource "google_compute_firewall" "deny_all_ingress" {
  name     = "deny-all-ingress"
  network  = var.vpc_self_link
  priority = 65534

  deny {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}





