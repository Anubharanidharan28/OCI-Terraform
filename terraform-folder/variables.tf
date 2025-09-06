# -----------------------------
# OCI Provider Variables
# -----------------------------
variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user calling the API"
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the API signing key"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private API signing key"
  type        = string
}

variable "region" {
  description = "The OCI region to deploy resources in"
  type        = string
}

# -----------------------------
# Compartment and Networking
# -----------------------------
variable "compartment_ocid" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "availability_domain" {
  description = "The availability domain to deploy resources in"
  type        = string
}

variable "vcn_cidr_block" {
  description = "CIDR block for the Virtual Cloud Network"
  type        = string
}

variable "vcn_display_name" {
  description = "Display name of the VCN"
  type        = string
}

variable "vcn_dns_label" {
  description = "DNS label for the VCN"
  type        = string
}

variable "internet_gateway_display_name" {
  description = "Display name for Internet Gateway"
  type        = string
}

variable "nat_gateway_display_name" {
  description = "Display name for NAT Gateway"
  type        = string
}

variable "public_route_table_display_name" {
  description = "Display name for Public Route Table"
  type        = string
}

variable "private_route_table_display_name" {
  description = "Display name for Private Route Table"
  type        = string
}

variable "public_subnet_display_name" {
  description = "Display name for Public Subnet"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for Public Subnet"
  type        = string
}

variable "private_subnet_display_name" {
  description = "Display name for Private Subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for Private Subnet"
  type        = string
}

# -----------------------------
# Compute Variables
# -----------------------------
variable "image_ocid" {
  description = "OCID of the OS image to use for instances"
  type        = string
}

variable "instance_shape" {
  description = "Shape of the VM instance"
  type        = string
}

variable "ssh_public_key" {
  description = "Path to SSH public key"
  type        = string
}

# Public VMs
variable "public_vm_count" {
  description = "Number of public VMs to create"
  type        = number
}

variable "public_vm_display_name" {
  description = "Display name for public VMs"
  type        = string
}

variable "public_vm_cpu_count" {
  description = "Number of OCPUs for public VMs"
  type        = number
}

variable "public_vm_memory_gbs" {
  description = "Memory in GBs for public VMs"
  type        = number
}

variable "public_vm_volume_storage_size" {
  description = "Boot volume size for public VMs (in GBs)"
  type        = number
}

# Private VMs
variable "private_vm_count" {
  description = "Number of private VMs to create"
  type        = number
}

variable "private_vm_display_name" {
  description = "Display name for private VMs"
  type        = string
}

variable "private_vm_cpu_count" {
  description = "Number of OCPUs for private VMs"
  type        = number
}

variable "private_vm_memory_gbs" {
  description = "Memory in GBs for private VMs"
  type        = number
}

variable "private_vm_volume_storage_size" {
  description = "Boot volume size for private VMs (in GBs)"
  type        = number
}

# -----------------------------
# Load Balancer Variables
# -----------------------------
variable "lb_display_name" {
  description = "Display name of the Load Balancer"
  type        = string
}

variable "lb_backend_set_name" {
  description = "Name of the backend set for the Load Balancer"
  type        = string
}

variable "lb_backend_set_port" {
  description = "Port number used by backend servers"
  type        = number
}

variable "hostname" {
  description = "Hostname for host-based routing in the Load Balancer"
  type        = string
}

