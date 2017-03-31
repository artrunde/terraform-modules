# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

output "api_stage_map" {
  value = "${zipmap(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, aws_api_gateway_deployment.proxy_public_api_deployment.*.stage_name)}"
}

output "api_urls" {
  value = ["${formatlist("https://%s.execute-api.%s.amazonaws.com/%s/", aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, var.region, aws_api_gateway_deployment.proxy_public_api_deployment.*.stage_name)}"]
}

output "api_lambda_integrations" {
  value = "${ zipmap(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, aws_lambda_function.lambda_dummy.*.function_name) }"
}