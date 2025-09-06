# -------------------------
# General Variables
# -------------------------
variable "compartment_ocid" {
  description = "OCID of the compartment where resources will be created"
  type        = string
}

variable "availability_domain" {
  description = "The availability domain to launch resources in (e.g., Uocm:PHX-AD-1)"
  type        = string
}

variable "vcn_id" {
  description = "OCID of the VCN"
  type        = string
}

variable "private_subnet_id" {
  description = "OCID of the private subnet for VMs"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block of the VCN"
  type        = string
}

variable "common_tags" {
  description = "Common freeform tags for all resources"
  type        = map(string)
}

# -------------------------
# Private VM Configuration
# -------------------------
variable "private_vm_count" {
  description = "Number of private VM instances to create"
  type        = number
}

variable "private_vm_display_name" {
  description = "Base display name for private VM instances"
  type        = string
}

variable "instance_shape" {
  description = "Shape of the VM instance"
  type        = string
}

variable "private_vm_cpu_count" {
  description = "Number of OCPUs for the VM"
  type        = number
}

variable "private_vm_memory_gbs" {
  description = "Memory in GBs for the VM"
  type        = number
}

variable "image_ocid" {
  description = "OCID of the image to launch VM from"
  type        = string
}

variable "ssh_public_key" {
  description = "Path to SSH public key file"
  type        = string
}

variable "private_vm_volume_size" {
  description = "Size of the volume attached to the VM in GB"
  type        = number
}
