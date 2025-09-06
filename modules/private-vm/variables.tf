# ---------------------
# General Variables
# ---------------------

variable "compartment_ocid" {
  description = "OCID of the compartment where resources will be created."
  type        = string
}

variable "availability_domain" {
  description = "The availability domain to launch resources in (e.g., 'kIdk:PHX-AD-1')."
  type        = string
}

variable "vcn_id" {
  description = "The OCID of the Virtual Cloud Network (VCN)."
  type        = string
}

variable "vcn_cidr" {
  description = "The CIDR block of the VCN for NSG ingress rules (e.g., 10.0.0.0/16)."
  type        = string
}

variable "common_tags" {
  description = "Freeform tags applied to all resources."
  type        = map(string)
}

# ---------------------
# VM Variables
# ---------------------

variable "private_vm_count" {
  description = "Number of private VMs to create."
  type        = number
}

variable "private_vm_display_name" {
  description = "Display name prefix for the private VM(s)."
  type        = string
}

variable "instance_shape" {
  description = "Shape of the private VM instance (e.g., VM.Standard.E4.Flex)."
  type        = string
}

variable "private_vm_cpu_count" {
  description = "Number of OCPUs for the private VM."
  type        = number
}

variable "private_vm_memory_gbs" {
  description = "Memory in GBs for the private VM."
  type        = number
}

variable "private_subnet_id" {
  description = "The OCID of the private subnet to attach the VM(s) to."
  type        = string
}

variable "image_ocid" {
  description = "The OCID of the image to use for the private VM(s)."
  type        = string
}

variable "ssh_public_key" {
  description = "Path to the SSH public key file used for VM access."
  type        = string
}

# ---------------------
# Storage Variables
# ---------------------

variable "private_vm_volume_storage_size" {
  description = "Size of the block storage volume for each private VM in GBs."
  type        = number
}
