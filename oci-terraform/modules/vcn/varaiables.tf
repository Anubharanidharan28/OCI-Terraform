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

variable "common_tags" {
  description = "Common freeform tags applied to all resources"
  type        = map(string)
}

# -------------------------
# VCN Variables
# -------------------------

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string
}

variable "vcn_display_name" {
  description = "Display name for the VCN"
  type        = string
}

variable "vcn_dns_label" {
  description = "DNS label for the VCN (must be unique in tenancy)"
  type        = string
}

# -------------------------
# Internet Gateway (IGW)
# -------------------------

variable "igw_display_name" {
  description = "Display name for the Internet Gateway"
  type        = string
}

# -------------------------
# NAT Gateway
# -------------------------

variable "nat_display_name" {
  description = "Display name for the NAT Gateway"
  type        = string
}

# -------------------------
# Route Tables
# -------------------------

variable "public_rt_display_name" {
  description = "Display name for the Public Route Table"
  type        = string
}

variable "private_rt_display_name" {
  description = "Display name for the Private Route Table"
  type        = string
}

# -------------------------
# Subnets
# -------------------------

variable "public_subnet_cidr" {
  description = "CIDR block for the Public Subnet"
  type        = string
}

variable "public_subnet_display_name" {
  description = "Display name for the Public Subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the Private Subnet"
  type        = string
}

variable "private_subnet_display_name" {
  description = "Display name for the Private Subnet"
  type        = string
}
