# -----------------------------
# VCN Outputs
# -----------------------------
output "vcn_id" {
  description = "OCID of the Virtual Cloud Network (VCN)"
  value       = module.vcn.vcn_id
}

output "vcn_display_name" {
  description = "Display name of the VCN"
  value       = module.vcn.vcn_display_name
}

# -----------------------------
# Internet Gateway Outputs
# -----------------------------
output "internet_gateway_id" {
  description = "OCID of the Internet Gateway attached to the VCN"
  value       = module.vcn.internet_gateway_id
}

output "igw_display_name" {
  description = "Display name of the Internet Gateway"
  value       = module.vcn.igw_display_name
}

# -----------------------------
# NAT Gateway Outputs
# -----------------------------
output "nat_gateway_id" {
  description = "OCID of the NAT Gateway attached to the VCN"
  value       = module.vcn.nat_gateway_id
}

output "nat_gateway_display_name" {
  description = "Display name of the NAT Gateway"
  value       = module.vcn.nat_gateway_display_name
}

# -----------------------------
# Route Table Outputs
# -----------------------------
output "public_route_table_id" {
  description = "OCID of the Public Route Table"
  value       = module.vcn.public_route_table_id
}

output "public_route_table_display_name" {
  description = "Display name of the Public Route Table"
  value       = module.vcn.public_route_table_display_name
}

output "private_route_table_id" {
  description = "OCID of the Private Route Table"
  value       = module.vcn.private_route_table_id
}

output "private_route_table_display_name" {
  description = "Display name of the Private Route Table"
  value       = module.vcn.private_route_table_display_name
}

# -----------------------------
# Subnet Outputs
# -----------------------------
output "public_subnet_id" {
  description = "OCID of the Public Subnet within the VCN"
  value       = module.vcn.public_subnet_id
}

output "public_subnet_display_name" {
  description = "Display name of the Public Subnet"
  value       = module.vcn.public_subnet_display_name
}

output "private_subnet_id" {
  description = "OCID of the Private Subnet within the VCN"
  value       = module.vcn.private_subnet_id
}

output "private_subnet_display_name" {
  description = "Display name of the Private Subnet"
  value       = module.vcn.private_subnet_display_name
}

# -------------------------
# Public VM Outputs
# -------------------------
output "public_vm_ids" {
  description = "List of OCIDs for all Public VM instances"
  value       = module.public-vm.public_vm_ids
}

output "public_vm_private_ips" {
  description = "Private IP addresses of all Public VM instances"
  value       = module.public-vm.public_vm_private_ips
}

output "public_vm_public_ips" {
  description = "Public IP addresses of all Public VM instances"
  value       = module.public-vm.public_vm_public_ips
}

output "public_vm_names" {
  description = "Display names of all Public VM instances"
  value       = module.public-vm.public_vm_names
}


# -------------------------
# Private VM Outputs
# -------------------------
output "private_vm_ids" {
  description = "List of OCIDs for all Private VM instances"
  value       = module.private-vm.private_vm_ids
}

output "private_vm_private_ips" {
  description = "Private IP addresses of all Private VM instances"
  value       = module.private-vm.private_vm_private_ips
}

output "private_vm_names" {
  description = "Display names of all Private VM instances"
  value       = module.private-vm.private_vm_names
}

# -------------------------
#Load Balancer Outputs
# -------------------------
output "lb_id" {
  description = "Display names of all Private VM instances"
  value       = module.load-balancer.lb_id
}

output "lb_display_name" {
  description = "Display names of all Private VM instances"
  value       = module.load-balancer.lb_display_name
}

output "lb_ip_addresses" {
  description = "Display names of all Private VM instances"
  value       = module.load-balancer.lb_ip_addresses
}

output "lb_backend_set_name" {
  description = "Display names of all Private VM instances"
  value       = module.load-balancer.lb_backend_set_name
}

output "lb_listener_name" {
  description = "Display names of all Private VM instances"
  value       = module.load-balancer.lb_listener_name
}

