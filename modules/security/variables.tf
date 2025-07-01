variable "vpc_self_link" {
  type        = string
  description = "Self-link of the VPC where firewall rules will apply"
}

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "allowed_ssh_source_ranges" {
  type        = list(string)
  default     = ["208.67.222.222/32"]
  description = "List of IPs allowed to SSH into frontend/app VMs"
}

variable "allowed_frontend_to_app" {
  type        = list(string)
  default     = ["frontend"]
  description = "Source tags or CIDRs allowed to reach app tier"
}

variable "allowed_app_to_db" {
  type        = list(string)
  default     = ["app"]
  description = "Source tags or CIDRs allowed to reach DB tier"
}

variable "app_port" {
  type        = number
  default     = 8080
  description = "Port used by application tier"
}

variable "db_port" {
  type        = number
  default     = 3306
  description = "Port used by database tier"
}

variable "enable_cloud_armor" {
  type        = bool
  default     = false
  description = "Enable Cloud Armor WAF for frontend"
}
