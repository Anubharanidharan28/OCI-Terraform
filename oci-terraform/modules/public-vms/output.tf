# -------------------------
# Public VM Outputs
# -------------------------

# Public VM OCIDs
output "public_vm_ids" {
  description = "List of Public VM Instance OCIDs"
  value       = oci_core_instance.public_vm[*].id
}

# Public VM Private IPs
output "public_vm_private_ips" {
  description = "Private IP addresses of Public VMs"
  value       = [for inst in oci_core_instance.public_vm : inst.private_ip]
}

# Public VM Public IPs
output "public_vm_public_ips" {
  description = "Public IP addresses of Public VMs"
  value       = [for inst in oci_core_instance.public_vm : inst.public_ip]
}

# Public VM Display Names
output "public_vm_names" {
  description = "Display names of Public VMs"
  value       = [for inst in oci_core_instance.public_vm : inst.display_name]
}

# Public VM Volumes
output "public_vm_volume_ids" {
  description = "List of Volume OCIDs attached to Public VMs"
  value       = oci_core_volume.public_vm_volume[*].id
}

# Public VM Volume Attachments
output "public_vm_volume_attachment_ids" {
  description = "Volume Attachment OCIDs for Public VMs"
  value       = oci_core_volume_attachment.public_vm_volume_attach[*].id
}

# Public VM NSG
output "public_vm_nsg_id" {
  description = "Network Security Group ID for Public VMs"
  value       = oci_core_network_security_group.public_vm_nsg.id
}

# Public VM NSG Rules
output "public_vm_nsg_ssh_rule_id" {
  description = "NSG Security Rule ID for SSH ingress"
  value       = oci_core_network_security_group_security_rule.public_vm_ssh_ingress.id
}

output "public_vm_nsg_egress_rule_id" {
  description = "NSG Security Rule ID for all egress"
  value       = oci_core_network_security_group_security_rule.public_vm_all_egress.id
}
