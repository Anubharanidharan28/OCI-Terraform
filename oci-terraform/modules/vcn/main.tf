# -------------------------
# VCN Resource
# -------------------------
resource "oci_core_vcn" "main_vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = var.vcn_cidr
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label

  freeform_tags = merge(
    {
      Name     = var.vcn_display_name
      Resource = "Virtual Cloud Network"
    },
    var.common_tags
  )
}

# -------------------------
# Internet Gateway (IGW) for Public Subnet
# -------------------------
resource "oci_core_internet_gateway" "main_igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = var.igw_display_name
  enabled        = true

  freeform_tags = merge(
    {
      Name     = var.igw_display_name
      Resource = "Internet Gateway"
    },
    var.common_tags
  )
}

# -------------------------
# Route Table for Public Subnet
# -------------------------
resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = var.public_rt_display_name

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.main_igw.id
  }

  freeform_tags = merge(
    {
      Name     = var.public_rt_display_name
      Resource = "Public Route Table"
    },
    var.common_tags
  )
}

# -------------------------
# Public Subnet (with Internet access)
# -------------------------
resource "oci_core_subnet" "public_subnet" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.main_vcn.id
  cidr_block                 = var.public_subnet_cidr
  display_name               = var.public_subnet_display_name
  availability_domain        = var.availability_domain
  route_table_id             = oci_core_route_table.public_rt.id
  security_list_ids          = [oci_core_security_list.public_sg.id]
  prohibit_public_ip_on_vnic = false # Allow Public IPs

  freeform_tags = merge(
    {
      Name     = var.public_subnet_display_name
      Resource = "Public Subnet"
    },
    var.common_tags
  )
}

# -------------------------
# NAT Gateway for Private Subnet
# -------------------------
resource "oci_core_nat_gateway" "main_nat" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = var.nat_display_name
  block_traffic  = false

  freeform_tags = merge(
    {
      Name     = var.nat_display_name
      Resource = "NAT Gateway"
    },
    var.common_tags
  )
}

# -------------------------
# Route Table for Private Subnet (using NAT Gateway)
# -------------------------
resource "oci_core_route_table" "private_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = var.private_rt_display_name

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.main_nat.id
  }

  freeform_tags = merge(
    {
      Name     = var.private_rt_display_name
      Resource = "Private Route Table"
    },
    var.common_tags
  )
}

# -------------------------
# Private Subnet (no Public IPs, outbound via NAT)
# -------------------------
resource "oci_core_subnet" "private_subnet" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.main_vcn.id
  cidr_block                 = var.private_subnet_cidr
  display_name               = var.private_subnet_display_name
  availability_domain        = var.availability_domain
  route_table_id             = oci_core_route_table.private_rt.id
  security_list_ids          = [oci_core_security_list.private_sg.id]
  prohibit_public_ip_on_vnic = true # Disallow Public IPs

  freeform_tags = merge(
    {
      Name     = var.private_subnet_display_name
      Resource = "Private Subnet"
    },
    var.common_tags
  )
}

# -------------------------
# Security List for Public Subnet
# -------------------------
resource "oci_core_security_list" "public_sg" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "${var.public_subnet_display_name}-sg"

  # Allow traffic within VCN
  ingress_security_rules {
    protocol    = "all"
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow all traffic within VCN"
  }

  # Allow all outbound
  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    stateless        = false
    description      = "Allow all outbound traffic"
  }

  freeform_tags = merge(
    {
      Name     = "${var.public_subnet_display_name}-sg"
      Resource = "Public Security List"
    },
    var.common_tags
  )
}

# -------------------------
# Security List for Private Subnet
# -------------------------
resource "oci_core_security_list" "private_sg" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "${var.private_subnet_display_name}-sg"

  # Allow traffic within VCN
  ingress_security_rules {
    protocol    = "all"
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow all traffic within VCN"
  }

  # Allow all outbound
  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    stateless        = false
    description      = "Allow all outbound traffic"
  }

  freeform_tags = merge(
    {
      Name     = "${var.private_subnet_display_name}-sg"
      Resource = "Private Security List"
    },
    var.common_tags
  )
}
