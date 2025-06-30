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
    default     = [ "208.67.222.222/32" ]
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