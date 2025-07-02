# Allow SSH only from specific IPs to frontend and app VMs
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

# Allow HTTP and HTTPS traffic to frontend VMs from anywhere
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

# Allow internal communication between all tiers (frontend, app, db) within the VPC
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

# Grant Compute Instance Admin role to specific users for project management
resource "google_project_iam_binding" "ssh_admin" {
  role    = "roles/compute.instanceAdmin.v1"
  project = var.project_id

  members = [
    "user:ayush.gharat.btech2023@atlasskilltech.university",
    "user:ayushgharat234@gmail.com"
  ]
}

# Allow traffic from frontend to app tier on the application port
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

# Allow traffic from app to db tier on the database port
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

# Deny all other ingress traffic by default for security
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

resource "google_compute_firewall" "allow_health_check" {
  name    = "allow-health-checks"
  network = var.vpc_self_link
  priority = 900

  direction = "INGRESS"
  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]
  target_tags = ["app"] # or the tag you apply to app-mig VMs

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  description = "Allow load balancer health checks to app instances"
}

resource "google_compute_firewall" "allow_health_check_db" {
  name    = "allow-health-checks-db"
  network = var.vpc_self_link
  priority = 901 # higher priority than deny-all-ingress

  direction = "INGRESS"
  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]
  target_tags = ["db"] # ensure your db-mig VMs use this tag

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  description = "Allow health checks to db-mig instances"
}




