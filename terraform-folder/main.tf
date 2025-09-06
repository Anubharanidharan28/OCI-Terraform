# -----------------------------
# OCI Provider Configuration
# -----------------------------
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

locals {
  ist_time       = timeadd(timestamp(), "5h30m")
  formatted_time = formatdate("DD-MMM-YYYY hh:mm aa", local.ist_time)

  common_tags = {
    Environment = ""
    Project     = ""
    Region      = ""
    Department  = "DevOps"
    Author      = "Anubharanidharan M and Abhilash Jetti"
    UpdatedAt   = local.formatted_time
    ManagedBy   = "Terraform"
  }
}


# ---------------------------------
# VCN and Networking Configuration
# ---------------------------------
module "vcn" {
  source = "/Users/in04180/github/local-terraform/modules/vcn"

  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain

  vcn_cidr_block   = var.vcn_cidr_block
  vcn_display_name = var.vcn_display_name
  vcn_dns_label    = var.vcn_dns_label

  igw_display_name    = var.internet_gateway_display_name
  nat_gw_display_name = var.nat_gateway_display_name

  public_rt_display_name  = var.public_route_table_display_name
  private_rt_display_name = var.private_route_table_display_name

  public_subnet_display_name = var.public_subnet_display_name
  public_subnet_cidr_block   = var.public_subnet_cidr_block

  private_subnet_display_name = var.private_subnet_display_name
  private_subnet_cidr_block   = var.private_subnet_cidr_block

  common_tags = local.common_tags
}

# ---------------------------------
# Public VMs Configuration (via module)
# ---------------------------------
module "public-vm" {
  source = "/Users/in04180/github/local-terraform/modules/public-vm"

  # General Configuration 
  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain
  image_ocid          = var.image_ocid
  ssh_public_key      = var.ssh_public_key
  instance_shape      = var.instance_shape

  # Public Virtual Machine configuration 
  public_vm_count               = var.public_vm_count
  public_vm_display_name        = var.public_vm_display_name
  public_vm_cpu_count           = var.public_vm_cpu_count
  public_vm_memory_gbs          = var.public_vm_memory_gbs
  public_vm_volume_storage_size = var.public_vm_volume_storage_size

  public_subnet_id = module.vcn.public_subnet_id
  vcn_id           = module.vcn.vcn_id

  common_tags = local.common_tags
}


# ---------------------------------
# Private VMs Configuration
# ---------------------------------
module "private-vm" {
  source = "/Users/in04180/github/local-terraform/modules/private-vm"

  # general Configuration 
  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain
  image_ocid          = var.image_ocid
  ssh_public_key      = var.ssh_public_key
  instance_shape      = var.instance_shape

  # Public Virtual Machine configuration 
  private_vm_count               = var.private_vm_count
  private_vm_display_name        = var.private_vm_display_name
  private_vm_cpu_count           = var.private_vm_cpu_count
  private_vm_memory_gbs          = var.private_vm_memory_gbs
  private_vm_volume_storage_size = var.private_vm_volume_storage_size
  vcn_cidr                       = var.vcn_cidr_block

  private_subnet_id = module.vcn.private_subnet_id
  vcn_id            = module.vcn.vcn_id

  common_tags = local.common_tags
}


# ---------------------------------
#  Load Balancer Configuration
# ---------------------------------
module "load-balancer" {
  source = "/Users/in04180/github/local-terraform/modules/load-balancer"

  # OCI Provider Configuration
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region

  compartment_ocid    = var.compartment_ocid
  lb_display_name     = var.lb_display_name
  lb_backend_set_name = var.lb_backend_set_name
  lb_backend_set_port = var.lb_backend_set_port
  hostname            = var.hostname

  public_subnet_id       = module.vcn.public_subnet_id
  private_vm_private_ips = module.private-vm.private_vm_private_ips

  common_tags = local.common_tags
}

# -----------------------------
# Export Terraform Outputs to JSON
# -----------------------------
resource "null_resource" "export_outputs" {
  provisioner "local-exec" {
    command     = <<EOT
      terraform output -json > /Users/in04180/github/local-terraform/output/terraform_outputs.json
    EOT
    working_dir = path.module
  }

  depends_on = [
    module.load-balancer,
    module.private-vm,
    module.public-vm,
    module.vcn
  ]
}