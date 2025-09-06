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
# Common Tags & Compartments
# -----------------------------

variable "compartment_ocid" {
  description = "The OCID of the compartment where all resources will be created."
  type        = string
}

variable "common_tags" {
  description = "Common freeform tags applied to all resources."
  type        = map(string)
}

# -----------------------------
# Load Balancer Configuration
# -----------------------------

variable "lb_display_name" {
  description = "Display name for the Load Balancer."
  type        = string
}

variable "public_subnet_id" {
  description = "The OCID of the public subnet where the load balancer will be deployed."
  type        = string
}

# -----------------------------
# Backend Set Configuration
# -----------------------------

variable "lb_backend_set_name" {
  description = "Name of the backend set for the load balancer."
  type        = string
}

variable "lb_backend_set_port" {
  description = "The port used by the backend servers (e.g., 8080, 3000, etc.)."
  type        = number
}

variable "private_vm_private_ips" {
  description = "Private IP addresses of the backend private Nomad VMs."
  type        = list(string)
}

# -----------------------------
# Hostname for Routing Policy
# -----------------------------

variable "hostname" {
  description = "The hostname used in the HTTP Host header for routing traffic."
  type        = string
}
