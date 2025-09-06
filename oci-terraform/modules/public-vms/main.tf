# -------------------------
# Public VM Instances
# -------------------------
resource "oci_core_instance" "public_vm" {
  count               = var.public_vm_count
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = var.public_vm_count == 1 ? var.public_vm_display_name : "${var.public_vm_display_name}_${count.index + 1}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.public_vm_cpu_count
    memory_in_gbs = var.public_vm_memory_gbs
  }

  create_vnic_details {
    subnet_id        = var.public_subnet_id
    assign_public_ip = true
    display_name     = var.public_vm_count == 1 ? var.public_vm_display_name : "${var.public_vm_display_name}_${count.index + 1}"
    nsg_ids          = [oci_core_network_security_group.public_vm_nsg.id]
  }

  source_details {
    source_type = "image"
    source_id   = var.image_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

  freeform_tags = {
    Name     = var.public_vm_count == 1 ? var.public_vm_display_name : "${var.public_vm_display_name}_${count.index + 1}"
    Resource = "Public VM"
  }
}

# -------------------------
# Volume for Public VMs
# -------------------------
resource "oci_core_volume" "public_vm_volume" {
  count               = var.public_vm_count
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = var.public_vm_count == 1 ? "${var.public_vm_display_name}_vol" : "${var.public_vm_display_name}_vol_${count.index + 1}"
  size_in_gbs         = var.public_vm_volume_size

  freeform_tags = {
    Name     = var.public_vm_count == 1 ? "${var.public_vm_display_name}_vol" : "${var.public_vm_display_name}_vol_${count.index + 1}"
    Resource = "VM Volume"
  }
}

# -------------------------
# Volume Attachment
# -------------------------
resource "oci_core_volume_attachment" "public_vm_volume_attach" {
  count       = var.public_vm_count
  instance_id = oci_core_instance.public_vm[count.index].id
  volume_id   = oci_core_volume.public_vm_volume[count.index].id
  display_name = var.public_vm_count == 1 ? "${var.public_vm_display_name}_vol_attach" : "${var.public_vm_display_name}_vol_attach_${count.index + 1}"
  attachment_type = "iscsi"
}

# -------------------------
# NSG for Public VMs (SSH + All Outbound)
# -------------------------
resource "oci_core_network_security_group" "public_vm_nsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = var.public_vm_count == 1 ? "${var.public_vm_display_name}_nsg" : "${var.public_vm_display_name}_nsg"

  freeform_tags = {
    Name     = var.public_vm_count == 1 ? "${var.public_vm_display_name}_nsg" : "${var.public_vm_display_name}_nsg"
    Resource = "Network Security Group"
  }
}

# Ingress Rule: Allow SSH
resource "oci_core_network_security_group_security_rule" "public_vm_ssh_ingress" {
  network_security_group_id = oci_core_network_security_group.public_vm_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }

  description = "Allow SSH from anywhere"
}

# Egress Rule: Allow all
resource "oci_core_network_security_group_security_rule" "public_vm_all_egress" {
  network_security_group_id = oci_core_network_security_group.public_vm_nsg.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination_type          = "CIDR_BLOCK"
  destination               = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}
