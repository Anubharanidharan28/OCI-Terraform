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


terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.0.0"
    }
  }
}

resource "oci_load_balancer" "lb" {
  compartment_id = var.compartment_ocid
  display_name   = var.lb_display_name
  shape          = "flexible"
  subnet_ids     = [var.public_subnet_id]

  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 100
  }


  freeform_tags = merge(
    {
      Name     = var.lb_display_name
      Resource = "Load Balancer"
    },
    var.common_tags
  )
}
# -----------------------------
# Backend Set 
# -----------------------------
resource "oci_load_balancer_backend_set" "lb_backend_set" {
  name             = var.lb_backend_set_name
  load_balancer_id = oci_load_balancer.lb.id
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol          = "TCP"
    port              = var.lb_backend_set_port
    retries           = 3
    timeout_in_millis = 3000
  }
}

resource "oci_load_balancer_backend" "vm_backend" {
  for_each = {
    for idx, ip in var.private_vm_private_ips :
    "vm-${idx}" => ip
  }

  load_balancer_id = oci_load_balancer.lb.id
  backendset_name  = oci_load_balancer_backend_set.lb_backend_set.name
  ip_address       = each.value
  port             = var.lb_backend_set_port
  weight           = 1
}


#Certificate
resource "oci_load_balancer_certificate" "lb_cert" {
  certificate_name   = "azentio.net"
  load_balancer_id   = oci_load_balancer.lb.id
  public_certificate = file("/Users/in04180/terraform/oci-terraform/oci_terraform_load_balancer_master_file/modules/load_balancer/public.pem")
  private_key        = file("/Users/in04180/terraform/oci-terraform/oci_terraform_load_balancer_master_file/modules/load_balancer/private.key")
}

resource "oci_load_balancer_load_balancer_routing_policy" "host_based_routing" {

  condition_language_version = "V1"
  load_balancer_id           = oci_load_balancer.lb.id
  name                       = "host_based_routing_policy"

  rules {
    name      = "route_to_backend_1"
    condition = "all(http.request.headers[(i 'host')] eq '${var.hostname}')"
    actions {
      name             = "FORWARD_TO_BACKENDSET"
      backend_set_name = oci_load_balancer_backend_set.lb_backend_set.name
    }
  }

}

# Listener
resource "oci_load_balancer_listener" "https_listener" {
  name                     = "https-listener"
  default_backend_set_name = oci_load_balancer_backend_set.lb_backend_set.name
  load_balancer_id         = oci_load_balancer.lb.id
  port                     = 443
  protocol                 = "HTTP" # HTTP with SSL config means HTTPS traffic is handled

  routing_policy_name = oci_load_balancer_load_balancer_routing_policy.host_based_routing.name

  ssl_configuration {
    certificate_name        = oci_load_balancer_certificate.lb_cert.certificate_name
    verify_peer_certificate = false
  }
}
