#---------------------
# Public VM Outputs
#---------------------

output "public_vm_ids" {
  description = "OCIDs of the public VM instances"
  value       = [for vm in oci_core_instance.public_vm : vm.id]
}

output "public_vm_names" {
  description = "Display names of the public VM instances"
  value       = [for vm in oci_core_instance.public_vm : vm.display_name]
}

output "public_vm_private_ips" {
  description = "Private IP addresses of the public VM instances"
  value       = [for vm in oci_core_instance.public_vm : vm.private_ip]
}

output "public_vm_public_ips" {
  description = "Public IP addresses of the public VM instances"
  value       = [for vm in oci_core_instance.public_vm : vm.public_ip]
}

#---------------------
# Block Volume Outputs
#---------------------

output "public_vm_volume_ids" {
  description = "OCIDs of the block volumes created for public VMs"
  value       = [for vol in oci_core_volume.public_vm_storage : vol.id]
}

output "public_vm_volume_names" {
  description = "Display names of the block volumes"
  value       = [for vol in oci_core_volume.public_vm_storage : vol.display_name]
}

#---------------------
# Network Security Group Outputs
#---------------------

output "public_vm_nsg_id" {
  description = "The OCID of the Network Security Group used by public VMs"
  value       = oci_core_network_security_group.public_vm_nsg.id
}

output "public_vm_nsg_name" {
  description = "Display name of the Network Security Group"
  value       = oci_core_network_security_group.public_vm_nsg.display_name
}
