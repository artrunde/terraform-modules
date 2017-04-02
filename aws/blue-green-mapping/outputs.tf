# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

output "staging" {
  value = "${replace(replace(var.active_stage, "/^[^b].*/", "blue"), "/^b.*$/", "green")}"
}

output "active" {
  value = "${aws_api_gateway_base_path_mapping.green.stage_name}"
}

output "active_url" {
  value = "https://${var.domain_name}/${var.version}/"
}