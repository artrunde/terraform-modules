# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

output "active" {
  value = "${var.active}"
}

output "active_url" {
  value = "https://${var.domain_name}/${var.version}/"
}

output "active_base_url" {
  value = "https://${var.domain_name}/"
}