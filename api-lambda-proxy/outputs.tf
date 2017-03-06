# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

output "http_stage_endpoint" {
  value = "https://${aws_api_gateway_rest_api.proxy_api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_deployment.proxy_api_deployment.stage_name}"
}