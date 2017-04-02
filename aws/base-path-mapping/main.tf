# ------------------------------------------------------------------------------
# BASE PATH MAPPING.
# ------------------------------------------------------------------------------

resource "aws_api_gateway_base_path_mapping" "proxy_public_api_mapping" {

  api_id      = "${ lookup(var.stage_map, var.active, "unknown") }"
  stage_name  = "${var.active}"
  domain_name = "${var.domain_name}"
  base_path   = "${var.version}"

}