output "frontend_firewall_rules" {
  value = [
    google_compute_firewall.allow_ssh.name,
    google_compute_firewall.allow_http_https.name
  ]
}