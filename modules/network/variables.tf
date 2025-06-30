variable "vpc_name" {
    type        = string 
    description = "Name of the VPC"
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