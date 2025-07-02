# Backend service for the frontend, connects the load balancer to the frontend instance group
resource "google_compute_backend_service" "frontend_backend" {
  name                  = "frontend-backend"
  protocol              = "HTTP"
  port_name             = "http"
  health_checks         = [var.health_check_self_link]
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  enable_cdn            = true
  security_policy       = var.enable_cloud_armor ? google_compute_security_policy.waf_policy.id : null

  backend {
    group = var.frontend_mig
  }

  log_config {
    enable       = true
    sample_rate  = 1.0
  }
}

# URL map to route incoming requests to the backend service
resource "google_compute_url_map" "url_map" {
  name            = "frontend-url-map"
  default_service = google_compute_backend_service.frontend_backend.self_link
}

# HTTP proxy to forward requests to the URL map
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "frontend-http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

# Global forwarding rule to direct external HTTP traffic to the proxy
resource "google_compute_global_forwarding_rule" "http_rule" {
  name                  = "frontend-http-rule"
  target                = google_compute_target_http_proxy.http_proxy.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
}

# Cloud Armor security policy (WAF) for the load balancer
resource "google_compute_security_policy" "waf_policy" {
  name = "basic-waf"

  rule {
    action   = "allow"
    priority = 1000
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Allow all traffic for testing"
  }

  rule {
    action   = "deny(403)"
    priority = 2147483647
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default deny rule"
  }
}
