#---------------------
# Public VM Instance
#---------------------
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
    subnet_id              = var.public_subnet_id
    assign_public_ip       = true
    display_name           = var.public_vm_count == 1 ? var.public_vm_display_name : "${var.public_vm_display_name}_${count.index + 1}"
    skip_source_dest_check = false
    nsg_ids                = [oci_core_network_security_group.public_vm_nsg.id]
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
      Name     = var.public_vm_display_name
      Resource = "Public Virtual Machines"
    },
    var.common_tags
  )
}

#---------------------
# Volume Storage for Public VM
#---------------------
resource "oci_core_volume" "public_vm_storage" {
  count               = var.public_vm_count
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = var.public_vm_count == 1 ? "${var.public_vm_display_name}_storage" : "${var.public_vm_display_name}_storage_${count.index + 1}"
  size_in_gbs         = var.public_vm_volume_storage_size

  freeform_tags = merge(
    {
      Name     = "${var.public_vm_display_name}_${count.index + 1}_storage"
      Resource = "Public Virtual Machine Storage"
    },
    var.common_tags
  )
}

#---------------------
# Volume Attachment for Public VM
#---------------------
resource "oci_core_volume_attachment" "public_vm_storage_attachment" {
  count           = var.public_vm_count
  instance_id     = oci_core_instance.public_vm[count.index].id
  volume_id       = oci_core_volume.public_vm_storage[count.index].id
  display_name    = var.public_vm_count == 1 ? "${var.public_vm_display_name}_storage_attachment" : "${var.public_vm_display_name}_storage_attachment_${count.index + 1}"
  attachment_type = "iscsi"
}

#---------------------
# Single Network Security Group (NSG)
#---------------------
resource "oci_core_network_security_group" "public_vm_nsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id

  display_name = "${var.public_vm_display_name}_nsg"

  freeform_tags = merge({
    Name     = "${var.public_vm_display_name}_nsg"
    Resource = "Network Security Group"
  }, var.common_tags)
}

#---------------------
# NSG Security Rules
#---------------------

# Ingress Rule: Allow SSH (Port 22)
resource "oci_core_network_security_group_security_rule" "ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.public_vm_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP

  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }

  description = "Allow SSH (TCP 22) from anywhere"
}

# Egress Rule: Allow All
resource "oci_core_network_security_group_security_rule" "egress_all" {
  network_security_group_id = oci_core_network_security_group.public_vm_nsg.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination_type          = "CIDR_BLOCK"
  destination               = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}
