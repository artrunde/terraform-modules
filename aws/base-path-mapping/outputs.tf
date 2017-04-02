# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

output "staging" {
  value = ""
}

output "active" {
  value = "${var.active_stage}"
}

output "active_url" {
  value = "https://${var.domain_name}/${var.version}/"
}