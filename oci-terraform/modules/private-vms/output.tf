# -------------------------
# Private VM Outputs
# -------------------------

# Private VM OCIDs
output "private_vm_ids" {
  description = "List of Private VM Instance OCIDs"
  value       = oci_core_instance.private_vm[*].id
}

# Private VM Private IPs
output "private_vm_private_ips" {
  description = "Private IP addresses of the private VMs"
  value = [
    for instance in oci_core_instance.private_vm : instance.private_ip
  ]
}


# Private VM Display Names
output "private_vm_names" {
  description = "Display names of Private VM instances"
  value       = [for inst in oci_core_instance.private_vm : inst.display_name]
}

# Private VM Volumes
output "private_vm_volume_ids" {
  description = "List of OCIDs of volumes attached to Private VMs"
  value       = oci_core_volume.private_vm_volume[*].id
}

# Private VM Volume Attachments
output "private_vm_volume_attachment_ids" {
  description = "Volume Attachment OCIDs for Private VMs"
  value       = oci_core_volume_attachment.private_vm_volume_attach[*].id
}

# Private VM NSG
output "private_vm_nsg_id" {
  description = "Network Security Group ID for Private VMs"
  value       = oci_core_network_security_group.private_vm_nsg.id
}

# Private VM NSG Rules
output "private_vm_nsg_ingress_vcn_rule_id" {
  description = "NSG Security Rule ID for allowing all inbound traffic from VCN"
  value       = oci_core_network_security_group_security_rule.private_vm_ingress_vcn.id
}

output "private_vm_nsg_egress_rule_id" {
  description = "NSG Security Rule ID for all outbound traffic from Private VMs"
  value       = oci_core_network_security_group_security_rule.private_vm_all_egress.id
}
