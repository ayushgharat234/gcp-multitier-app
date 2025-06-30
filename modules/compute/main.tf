resource "google_compute_instance_template" "template" {
    name_prefix = "${var.instance_prefix}-tmpl"
    project     = var.project_id
    region      = var.region

    machine_type = var.machine_type
    tags         = var.instance_tags

    disk {
        source_image = "debian-cloud/debian-11"
        auto_delete  = true
        boot         = true
    }

    network_interface {
        subnetwork = var.subnet
        access_config {}
    }

    metadata_startup_script = var.startup_script
    labels = {
      tier = var.instance_prefix
    }
}

resource "google_compute_region_instance_group_manager" "mig" {
    name               = "${var.instance_prefix}-mig"
    project            = var.project_id
    region             = var.region
    base_instance_name = "${var.instance_prefix}-vm"

    version {
        instance_template = google_compute_instance_template.template.self_link
        name              = "v1"
    }

    target_size = 2

    auto_healing_policies {
        initial_delay_sec = 300
        health_check      =  google_compute_health_check.http_health_check.self_link
    }
}

resource "google_compute_health_check" "http_health_check" {
    name        = "${var.instance_prefix}-http-health-check"
    project     = var.project_id
    description = "HTTP health check for ${var.instance_prefix} instances"

    check_interval_sec  = 5
    timeout_sec         = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2

    http_health_check {
      port = 80
      request_path = "/"
    }

    tcp_health_check {
      port = 22
    }

    ssl_health_check {
      port = 443
    }
}