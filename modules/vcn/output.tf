#---------------------
# VCN Output
#---------------------
output "vcn_id" {
  description = "OCID of the created VCN"
  value       = oci_core_vcn.main_vcn.id
}

#---------------------
# Internet Gateway Output
#---------------------
output "internet_gateway_id" {
  description = "OCID of the Internet Gateway"
  value       = oci_core_internet_gateway.main_igw.id
}

#---------------------
# NAT Gateway Output
#---------------------
output "nat_gateway_id" {
  description = "OCID of the NAT Gateway"
  value       = oci_core_nat_gateway.main_nat_gw.id
}

#---------------------
# Route Table Outputs
#---------------------
output "public_route_table_id" {
  description = "OCID of the Public Route Table"
  value       = oci_core_route_table.public_rt.id
}

output "private_route_table_id" {
  description = "OCID of the Private Route Table"
  value       = oci_core_route_table.private_rt.id
}

#---------------------
# Subnet Outputs
#---------------------
output "public_subnet_id" {
  description = "OCID of the Public Subnet"
  value       = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "OCID of the Private Subnet"
  value       = oci_core_subnet.private_subnet.id
}

#---------------------
# Security List Outputs
#---------------------
output "public_security_list_id" {
  description = "OCID of the Public Security List"
  value       = oci_core_security_list.public_sl.id
}

output "private_security_list_id" {
  description = "OCID of the Private Security List"
  value       = oci_core_security_list.private_sl.id
}

#---------------------
# Optional: All Display Names
#---------------------
output "vcn_display_name" {
  description = "Display name of the VCN"
  value       = oci_core_vcn.main_vcn.display_name
}

output "igw_display_name" {
  description = "Display name of the Internet Gateway"
  value       = oci_core_internet_gateway.main_igw.display_name
}

output "nat_gateway_display_name" {
  description = "Display name of the NAT Gateway"
  value       = oci_core_nat_gateway.main_nat_gw.display_name
}

output "public_route_table_display_name" {
  description = "Display name of the Public Route Table"
  value       = oci_core_route_table.public_rt.display_name
}

output "private_route_table_display_name" {
  description = "Display name of the Private Route Table"
  value       = oci_core_route_table.private_rt.display_name
}

output "public_subnet_display_name" {
  description = "Display name of the Public Subnet"
  value       = oci_core_subnet.public_subnet.display_name
}

output "private_subnet_display_name" {
  description = "Display name of the Private Subnet"
  value       = oci_core_subnet.private_subnet.display_name
}

output "public_security_list_display_name" {
  description = "Display name of the Public Security List"
  value       = oci_core_security_list.public_sl.display_name
}

output "private_security_list_display_name" {
  description = "Display name of the Private Security List"
  value       = oci_core_security_list.private_sl.display_name
}
