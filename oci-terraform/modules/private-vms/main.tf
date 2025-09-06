# -------------------------
# Private VM Instances
# -------------------------
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
    subnet_id        = var.private_subnet_id
    assign_public_ip = false
    display_name     = var.private_vm_count == 1 ? var.private_vm_display_name : "${var.private_vm_display_name}_${count.index + 1}"
    nsg_ids          = [oci_core_network_security_group.private_vm_nsg.id]
  }

  source_details {
    source_type = "image"
    source_id   = var.image_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

  freeform_tags = {
    Name     = var.private_vm_count == 1 ? var.private_vm_display_name : "${var.private_vm_display_name}_${count.index + 1}"
    Resource = "Private VM"
  }
}

# -------------------------
# Volume for Private VMs
# -------------------------
resource "oci_core_volume" "private_vm_volume" {
  count               = var.private_vm_count
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = var.private_vm_count == 1 ? "${var.private_vm_display_name}_vol" : "${var.private_vm_display_name}_vol_${count.index + 1}"
  size_in_gbs         = var.private_vm_volume_size

  freeform_tags = {
    Name     = var.private_vm_count == 1 ? "${var.private_vm_display_name}_vol" : "${var.private_vm_display_name}_vol_${count.index + 1}"
    Resource = "Private VM Volume"
  }
}

# -------------------------
# Volume Attachment
# -------------------------
resource "oci_core_volume_attachment" "private_vm_volume_attach" {
  count       = var.private_vm_count
  instance_id = oci_core_instance.private_vm[count.index].id
  volume_id   = oci_core_volume.private_vm_volume[count.index].id
  display_name = var.private_vm_count == 1 ? "${var.private_vm_display_name}_vol_attach" : "${var.private_vm_display_name}_vol_attach_${count.index + 1}"
  attachment_type = "iscsi"
}

# -------------------------
# NSG for Private VMs (VCN Only + All Outbound)
# -------------------------
resource "oci_core_network_security_group" "private_vm_nsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = var.private_vm_count == 1 ? "${var.private_vm_display_name}_nsg" : "${var.private_vm_display_name}_nsg"

  freeform_tags = {
    Name     = var.private_vm_count == 1 ? "${var.private_vm_display_name}_nsg" : "${var.private_vm_display_name}_nsg"
    Resource = "Private VM NSG"
  }
}

# Ingress Rule: Allow all traffic within VCN
resource "oci_core_network_security_group_security_rule" "private_vm_ingress_vcn" {
  network_security_group_id = oci_core_network_security_group.private_vm_nsg.id
  direction                 = "INGRESS"
  protocol                  = "all"
  source_type               = "CIDR_BLOCK"
  source                    = var.vcn_cidr

  description = "Allow all inbound traffic from VCN"
}

# Egress Rule: Allow all outbound
resource "oci_core_network_security_group_security_rule" "private_vm_all_egress" {
  network_security_group_id = oci_core_network_security_group.private_vm_nsg.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination_type          = "CIDR_BLOCK"
  destination               = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}
