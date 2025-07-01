variable "project_id" {
  type        = string
  description = "The GCP project ID where resources will be deployed."
}

variable "region" {
  type        = string
  description = "The GCP region for deploying VM instances and associated resources."
}

variable "instance_prefix" {
  type        = string
  description = "A prefix used for naming VM instances to ensure uniqueness and organization."
}

variable "subnet" {
  type        = string
  description = "The name of the subnetwork to which the VM instance will be attached."
}

variable "machine_type" {
  type        = string
  default     = "e2-medium"
  description = "The machine type (e.g., e2-medium, n1-standard-1) for the VM instance."
}

variable "instance_tags" {
  type        = list(string)
  default     = []
  description = "A list of network tags to apply to the VM instance for firewall rules and routing."
}

variable "startup_script" {
  type        = string
  description = "A multi-line script that will be executed when the VM instance first starts up."
}