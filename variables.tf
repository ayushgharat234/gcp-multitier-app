variable "vpc_name" {
  type        = string
  description = "Name of the VPC where firewall rules will apply"
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

variable "subnets" {
  type = list(object({
    name                  = string
    region                = string
    cidr                  = string
    private_google_access = bool
  }))
  description = "List of subnets to create"
}

variable "nat_region" {
  type        = string
  description = "Region of NAT Gateway and Router"
}

variable "region" {
  type        = string
  description = "Primary region for VM deployments"
}

variable "frontend_subnet" {
  type        = string
  description = "Name of the frontend subnet (for VM NICs)"
}

variable "app_subnet" {
  type        = string
  description = "Name of the app subnet (for VM NICs)"
}

variable "machine_type" {
  type        = string
  default     = "e2-medium"
  description = "Machine type for Compute Engine VMs"
}

variable "allowed_frontend_to_app" {
  type        = list(string)
  default     = ["frontend"] # Can also use CIDR like "10.10.10.0/24"
  description = "Source tags or CIDRs allowed to reach app tier"
}

variable "allowed_app_to_db" {
  type        = list(string)
  default     = ["app"] # Can also use "10.10.20.0/24"
  description = "Source tags or CIDRs allowed to reach db tier"
}

variable "db_port" {
  type        = number
  default     = 3306
  description = "Port the database listens on (MySQL default)"
}

variable "app_port" {
  type        = number
  default     = 8080
  description = "Port the application tier listens on"
}

variable "enable_cloud_armor" {
  type        = bool
  default     = true
  description = "Enable or disable Cloud Armor WAF for frontend"
}
