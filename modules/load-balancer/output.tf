# -----------------------------
# Load Balancer Outputs
# -----------------------------

output "lb_id" {
  description = "The OCID of the Load Balancer"
  value       = oci_load_balancer.lb.id
}

output "lb_display_name" {
  description = "Display name of the Load Balancer"
  value       = oci_load_balancer.lb.display_name
}

output "lb_ip_addresses" {
  description = "IP addresses assigned to the Load Balancer"
  value       = oci_load_balancer.lb.ip_address_details[*].ip_address
}

output "lb_backend_set_name" {
  description = "The name of the backend set associated with the Load Balancer"
  value       = oci_load_balancer_backend_set.lb_backend_set.name
}

output "lb_certificate_name" {
  description = "The name of the certificate uploaded to the Load Balancer"
  value       = oci_load_balancer_certificate.lb_cert.certificate_name
}

output "lb_listener_name" {
  description = "The name of the HTTPS listener"
  value       = oci_load_balancer_listener.https_listener.name
}
