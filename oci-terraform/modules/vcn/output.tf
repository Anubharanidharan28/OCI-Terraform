# # -------------------------
# # VCN Outputs
# # -------------------------
output "vcn_id" {
  description = "OCID of the VCN"
  value       = oci_core_vcn.main_vcn.id
}

output "vcn_display_name" {
  description = "Display name of the VCN"
  value       = oci_core_vcn.main_vcn.display_name
}

# -------------------------
# Internet Gateway (IGW) Outputs
# -------------------------
output "igw_id" {
  description = "OCID of the Internet Gateway"
  value       = oci_core_internet_gateway.main_igw.id
}

output "igw_display_name" {
  description = "Display name of the Internet Gateway"
  value       = oci_core_internet_gateway.main_igw.display_name
}

# -------------------------
# NAT Gateway Outputs
# -------------------------
output "nat_gateway_id" {
  description = "OCID of the NAT Gateway"
  value       = oci_core_nat_gateway.main_nat.id
}

output "nat_gateway_display_name" {
  description = "Display name of the NAT Gateway"
  value       = oci_core_nat_gateway.main_nat.display_name
}

# -------------------------
# Route Table Outputs
# -------------------------
output "public_rt_id" {
  description = "OCID of the Public Route Table"
  value       = oci_core_route_table.public_rt.id
}

output "private_rt_id" {
  description = "OCID of the Private Route Table"
  value       = oci_core_route_table.private_rt.id
}

# # -------------------------
# # Subnet Outputs
# # -------------------------
output "public_subnet_id" {
  description = "OCID of the Public Subnet"
  value       = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "OCID of the Private Subnet"
  value       = oci_core_subnet.private_subnet.id
}

output "public_subnet_cidr" {
  description = "CIDR block of the Public Subnet"
  value       = oci_core_subnet.public_subnet.cidr_block
}

output "private_subnet_cidr" {
  description = "CIDR block of the Private Subnet"
  value       = oci_core_subnet.private_subnet.cidr_block
}

# -------------------------
# Security List Outputs
# -------------------------
output "public_sg_id" {
  description = "OCID of the Public Security List"
  value       = oci_core_security_list.public_sg.id
}

output "private_sg_id" {
  description = "OCID of the Private Security List"
  value       = oci_core_security_list.private_sg.id
}
