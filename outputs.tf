output "vpc_self_link" {
  description = "Self-link of the created VPC"
  value       = module.network.vpc_self_link
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = module.network.subnet_ids
}

output "frontend_firewall_rules" {
  description = "Names of firewall rules for frontend"
  value       = module.security.frontend_firewall_rules
}

output "load_balancer_ip" {
  description = "The external IP address of the HTTP load balancer."
  value       = module.loadbalancer.load_balancer_ip
}

output "subnet_self_links" {
  value = module.network.subnet_self_links
}
