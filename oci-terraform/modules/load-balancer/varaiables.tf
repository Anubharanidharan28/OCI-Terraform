# ---------------------------------
# OCI Provider Authentication
# ---------------------------------

variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user."
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the API key."
  type        = string
}

variable "private_key_path" {
  description = "The local path to the private API key file."
  type        = string
}

variable "region" {
  description = "OCI region (e.g., ap-hyderabad-1)."
  type        = string
}

# -----------------------------
# Load Balancer Variables
# -----------------------------
variable "compartment_ocid" {
  description = "OCID of the compartment where LB will be created"
  type        = string
}

variable "lb_display_name" {
  description = "Display name of the Load Balancer"
  type        = string
}

variable "public_subnet_id" {
  description = "OCID of the public subnet to host the Load Balancer"
  type        = string
}

variable "lb_backend_set_name" {
  description = "Name of the Load Balancer backend set"
  type        = string
}

variable "lb_backend_set_port" {
  description = "Port for backend servers"
  type        = number
  default     = 80
}

variable "private_vm_private_ips" {
  description = "List of private IP addresses of backend VMs"
  type        = list(string)
}

variable "hostname" {
  description = "Hostname for host-based routing policy"
  type        = string
}

variable "common_tags" {
  description = "Optional map of common tags to apply to resources"
  type        = map(string)
}
