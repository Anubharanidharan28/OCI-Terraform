#---------------------
# Private VM Instance
#---------------------
resource "oci_core_instance" "private_vm" {
  count               = var.private_vm_count
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = var.private_vm_count == 1 ? var.private_vm_display_name : "${var.private_vm_display_name}_${count.index + 1}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.private_vm_cpu_count
    memory_in_gbs = var.private_vm_memory_gbs
  }

  create_vnic_details {
    subnet_id              = var.private_subnet_id
    assign_public_ip       = false
    display_name           = var.private_vm_count == 1 ? var.private_vm_display_name : "${var.private_vm_display_name}_${count.index + 1}"
    skip_source_dest_check = false
    nsg_ids                = [oci_core_network_security_group.private_vm_nsg.id]
  }

  source_details {
    source_type = "image"
    source_id   = var.image_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

  freeform_tags = merge(
    {
      Name     = var.private_vm_display_name
      Resource = "Private Virtual Machines"
    },
    var.common_tags
  )
}

#---------------------
# Volume Storage for Private VM
#---------------------
resource "oci_core_volume" "private_vm_storage" {
  count               = var.private_vm_count
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = var.private_vm_count == 1 ? "${var.private_vm_display_name}_storage" : "${var.private_vm_display_name}_storage_${count.index + 1}"
  size_in_gbs         = var.private_vm_volume_storage_size

  freeform_tags = merge(
    {
      Name     = "${var.private_vm_display_name}_${count.index + 1}_storage"
      Resource = "Private Virtual Machine Storage"
    },
    var.common_tags
  )
}

#---------------------
# Volume Attachment for Private VM
#---------------------
resource "oci_core_volume_attachment" "private_vm_storage_attachment" {
  count           = var.private_vm_count
  instance_id     = oci_core_instance.private_vm[count.index].id
  volume_id       = oci_core_volume.private_vm_storage[count.index].id
  display_name    = var.private_vm_count == 1 ? "${var.private_vm_display_name}_storage_attachment" : "${var.private_vm_display_name}_storage_attachment_${count.index + 1}"
  attachment_type = "iscsi"
}

#---------------------
# Single Network Security Group (NSG)
#---------------------
resource "oci_core_network_security_group" "private_vm_nsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id

  display_name = "${var.private_vm_display_name}_nsg"

  freeform_tags = merge({
    Name     = "${var.private_vm_display_name}_nsg"
    Resource = "Network Security Group"
  }, var.common_tags)
}

#---------------------
# NSG Security Rules
#---------------------

# Ingress Rule: Allow all traffic from VCN CIDR
resource "oci_core_network_security_group_security_rule" "ingress_all_vcn" {
  network_security_group_id = oci_core_network_security_group.private_vm_nsg.id
  direction                 = "INGRESS"
  protocol                  = "all"

  source_type = "CIDR_BLOCK"
  source      = var.vcn_cidr   # Pass your full VCN CIDR here, e.g. "10.0.0.0/16"

  description = "Allow all inbound traffic from within the VCN"
}


# Egress Rule: Allow All
resource "oci_core_network_security_group_security_rule" "egress_all_private" {
  network_security_group_id = oci_core_network_security_group.private_vm_nsg.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination_type          = "CIDR_BLOCK"
  destination               = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}
