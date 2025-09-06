# -----------------------------
# OCI Provider
# -----------------------------
tenancy_ocid     = ""
user_ocid        = ""
fingerprint      = ""
private_key_path = ""
region           = ""

# -----------------------------
# Compartment & Networking
# -----------------------------
compartment_ocid    = ""
availability_domain = "lNRl:AP-MUMBAI-1-AD-1"

vcn_cidr_block   = "10.0.0.0/22"
vcn_display_name = "test_VCN"
vcn_dns_label    = "defaultvcn"

internet_gateway_display_name    = "test_igw"
nat_gateway_display_name         = "test_nat_gw"
public_route_table_display_name  = "test_pub_rt"
private_route_table_display_name = "test_pri_rt"

public_subnet_display_name = "test_pub_sub1"
public_subnet_cidr_block   = "10.0.0.0/26"

private_subnet_display_name = "test_pri_sub1"
private_subnet_cidr_block   = "10.0.0.64/26"

# -----------------------------
# VM Configuration
# -----------------------------
image_ocid     = ""
ssh_public_key = ""
instance_shape = "VM.Standard.E5.Flex"

# Public VM
public_vm_count               = 1
public_vm_display_name        = "public_jump_server"
public_vm_cpu_count           = 2
public_vm_memory_gbs          = 8
public_vm_volume_storage_size = 50

# Private VM
private_vm_count               = 3
private_vm_display_name        = "test_private_vm"
private_vm_cpu_count           = 2
private_vm_memory_gbs          = 4
private_vm_volume_storage_size = 50

# -----------------------------
# Load Balancer Configuration
# -----------------------------
lb_display_name     = "load_balancer"
lb_backend_set_name = "application_backend_set"
lb_backend_set_port = 9090
hostname            = ""
