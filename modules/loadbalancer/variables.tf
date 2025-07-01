variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "frontend_mig" {
  type = string
}

variable "ssl_certificate_name" {
  type    = string
  default = "multitier-ssl"
}

variable "health_check_self_link" {
  type        = string
  description = "Self-link to the pre-created health check"
}

variable "enable_cloud_armor" {
  type        = bool
  default     = true
  description = "Toggle to enable Cloud Armor policy"
}
