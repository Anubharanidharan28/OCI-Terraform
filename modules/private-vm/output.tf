# ---------------------
# VM Outputs
# ---------------------

output "private_vm_ids" {
  description = "The OCIDs of the created private VM instances."
  value       = [for instance in oci_core_instance.private_vm : instance.id]
}

output "private_vm_names" {
  description = "The display names of the created private VM instances."
  value       = [for instance in oci_core_instance.private_vm : instance.display_name]
}

output "private_vm_private_ips" {
  description = "Private IP addresses of the private VMs"
  value = [
    for instance in oci_core_instance.private_vm : instance.private_ip
  ]
}

# ---------------------
# Storage Outputs
# ---------------------

output "private_vm_storage_ids" {
  description = "The OCIDs of the block storage volumes created for private VMs."
  value       = [for vol in oci_core_volume.private_vm_storage : vol.id]
}

output "private_vm_storage_names" {
  description = "The display names of the private VM storage volumes."
  value       = [for vol in oci_core_volume.private_vm_storage : vol.display_name]
}

# ---------------------
# Network Outputs
# ---------------------

output "private_vm_nsg_id" {
  description = "The OCID of the private VM Network Security Group (NSG)."
  value       = oci_core_network_security_group.private_vm_nsg.id
}

output "private_vm_nsg_name" {
  description = "The display name of the private VM Network Security Group (NSG)."
  value       = oci_core_network_security_group.private_vm_nsg.display_name
}
