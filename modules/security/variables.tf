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