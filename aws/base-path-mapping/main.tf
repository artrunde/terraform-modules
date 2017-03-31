# ------------------------------------------------------------------------------
# BASE PATH MAPPING.
# ------------------------------------------------------------------------------

resource "aws_api_gateway_base_path_mapping" "rodin_proxy_public_api_mapping" {

  // { v1 = "api_id:stage_name" }
  count       = "${length(keys(var.api_version_map))}"

  api_id      = "${ element( split(":", element(values(var.api_version_map), count.index)), 0) }"
  stage_name  = "${ element( split(":", element(values(var.api_version_map), count.index)), 1) }"
  domain_name = "${var.domain_name}"
  base_path   = "${element(keys(var.api_version_map), count.index)}"

}