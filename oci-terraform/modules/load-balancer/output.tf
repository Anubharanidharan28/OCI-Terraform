# -----------------------------
# Load Balancer Outputs
# -----------------------------

# Load Balancer OCID
output "load_balancer_id" {
  description = "OCID of the Load Balancer"
  value       = oci_load_balancer.lb.id
}

# Load Balancer IP Addresses
output "load_balancer_ips" {
  description = "Public IP addresses of the Load Balancer"
  value       = oci_load_balancer.lb.ip_addresses
}

# Load Balancer Display Name
output "load_balancer_name" {
  description = "Display name of the Load Balancer"
  value       = oci_load_balancer.lb.display_name
}

# Backend Set OCID
output "backend_set_id" {
  description = "OCID of the Load Balancer Backend Set"
  value       = oci_load_balancer_backend_set.lb_backend_set.id
}

# Backend Set Name
output "backend_set_name" {
  description = "Name of the Load Balancer Backend Set"
  value       = oci_load_balancer_backend_set.lb_backend_set.name
}

# Attached Backend IPs
output "backend_ips" {
  description = "List of IP addresses attached to the Backend Set"
  value       = [for backend in oci_load_balancer_backend.vm_backend : backend.ip_address]
}

# Listener OCID
output "https_listener_id" {
  description = "OCID of the HTTPS Listener"
  value       = oci_load_balancer_listener.https_listener.id
}

# Listener Name
output "https_listener_name" {
  description = "Name of the HTTPS Listener"
  value       = oci_load_balancer_listener.https_listener.name
}

# Certificate OCID
output "certificate_id" {
  description = "OCID of the Load Balancer Certificate"
  value       = oci_load_balancer_certificate.lb_cert.id
}

# Certificate Name
output "certificate_name" {
  description = "Name of the Load Balancer Certificate"
  value       = oci_load_balancer_certificate.lb_cert.certificate_name
}
