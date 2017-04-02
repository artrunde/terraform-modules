# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

output "stage_map" {
  value = "${map(aws_api_gateway_deployment.proxy_public_api_deployment.stage_name, aws_api_gateway_rest_api.proxy_public_api.id)}"
}

output "url" {
  value = "${ map(aws_api_gateway_deployment.proxy_public_api_deployment.stage_name, format("https://%s.execute-api.%s.amazonaws.com/%s/", aws_api_gateway_rest_api.proxy_public_api.id, var.region, aws_api_gateway_deployment.proxy_public_api_deployment.stage_name) ) }"
}

output "lambda_integration" {
  value = "${ map(aws_api_gateway_deployment.proxy_public_api_deployment.stage_name, aws_lambda_function.lambda_dummy.function_name) }"
}

output "api_id" {
  value = "${ aws_api_gateway_rest_api.proxy_public_api.id }"
}

output "stage_name" {
  value = "${ aws_api_gateway_deployment.proxy_public_api_deployment.stage_name }"
}