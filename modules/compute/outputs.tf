output "instance_group_name" {
  value = google_compute_region_instance_group_manager.mig.name
}

output "instance_template" {
  value = google_compute_instance_template.template.self_link
}

output "health_check_self_link" {
  value = google_compute_health_check.http_health_check.self_link
}

output "instance_group_self_link" {
  value = google_compute_region_instance_group_manager.mig.instance_group
}
