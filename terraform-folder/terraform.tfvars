# -----------------------------
# OCI Provider
# -----------------------------
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaap4n3h4q2nr7cufaxfl3lseug52ihkr2v5fg2eiyhjo77cn3sh43q"
user_ocid        = "ocid1.user.oc1..aaaaaaaalkote6xvfagvw6gmewonmlxs5lyry7u3ywsrpj7dko2gzdb7q6dq"
fingerprint      = "2a:71:b0:38:81:22:63:02:55:86:da:d4:f5:36:15:05"
private_key_path = "/Users/in04180/terraform/oci-devamlock-config-file/oci_api_key_nopass.pem"
region           = "ap-mumbai-1"

# -----------------------------
# Compartment & Networking
# -----------------------------
compartment_ocid    = "ocid1.compartment.oc1..aaaaaaaarp6s5t2c5yjsp3b43cwjv3d7tylwziustsfcjk6ynhy543ewmkya"
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
image_ocid     = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaakzaslqq67a7jsxckjssmq33per4sdm7gyxv7cpul6qia54mt7mdq"
ssh_public_key = "/Users/in04180/terraform/oci-terraform/oci-imal-dev/modules/vms/imal-dev.pem.pub"
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
hostname            = "test.lb.azentio.net"
