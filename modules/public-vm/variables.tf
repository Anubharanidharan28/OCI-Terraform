#---------------------
# General Variables
#---------------------

variable "compartment_ocid" {
  description = "The OCID of the compartment in which to create resources"
  type        = string
}

variable "availability_domain" {
  description = "The availability domain to launch instances"
  type        = string
}

variable "vcn_id" {
  description = "The OCID of the VCN where NSG will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "The OCID of the public subnet where VM will be created"
  type        = string
}

variable "image_ocid" {
  description = "The OCID of the image to use for the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "Path to the SSH public key file for instance login"
  type        = string
}

variable "common_tags" {
  description = "Common freeform tags to apply to all resources"
  type        = map(string)
}

#---------------------
# Public VM Variables
#---------------------

variable "public_vm_count" {
  description = "Number of public VM instances to create"
  type        = number
}

variable "public_vm_display_name" {
  description = "Display name prefix for the public VM(s)"
  type        = string
}

variable "instance_shape" {
  description = "Shape of the VM (e.g., VM.Standard.E4.Flex)"
  type        = string
}

variable "public_vm_cpu_count" {
  description = "Number of OCPUs to assign to the VM shape config"
  type        = number
}

variable "public_vm_memory_gbs" {
  description = "Amount of memory (GB) to assign to the VM shape config"
  type        = number
}

variable "public_vm_volume_storage_size" {
  description = "Size (in GBs) of the block volume to attach to each VM"
  type        = number
}
