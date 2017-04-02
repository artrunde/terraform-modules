# ------------------------------------------------------------------------------
# BASE PATH MAPPING.
# ------------------------------------------------------------------------------

resource "aws_api_gateway_base_path_mapping" "blue" {

  count       = "${replace(replace(var.active_stage, "/^[^b].*/", "0"), "/^b.*$/", "1")}"

  api_id      = "${ lookup(var.stage_map, "blue", "unknown") }"
  stage_name  = "blue"
  domain_name = "${var.domain_name}"
  base_path   = "${var.version}"

}

resource "aws_api_gateway_base_path_mapping" "green" {

  count       = "${replace(replace(var.active_stage, "/^[^g].*/", "0"), "/^g.*$/", "1")}"

  api_id      = "${ lookup(var.stage_map, "green", "unknown") }"
  stage_name  = "green"
  domain_name = "${var.domain_name}"
  base_path   = "${var.version}"

}