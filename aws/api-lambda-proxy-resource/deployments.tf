# ------------------------------------------------------------------------------
# API
# ------------------------------------------------------------------------------

resource "aws_api_gateway_rest_api" "proxy_public_api" {

  name = "${var.namespace}_${var.api_version}_${var.stage_name}_${var.terra_env}"
}

# ------------------------------------------------------------------------------
# DEPLOYMENTS
# ------------------------------------------------------------------------------

resource "aws_api_gateway_deployment" "proxy_public_api_deployment" {

  depends_on  = ["aws_api_gateway_integration_response.proxy_api_integration_response","aws_api_gateway_method.proxy_request_method","aws_api_gateway_method_response.200"]
  rest_api_id = "${aws_api_gateway_rest_api.proxy_public_api.id}"
  stage_name  = "${var.stage_name}"

}

resource "aws_api_gateway_method" "proxy_request_method" {

  rest_api_id   = "${aws_api_gateway_rest_api.proxy_public_api.id}"
  resource_id   = "${aws_api_gateway_resource.proxy_api_resource_proxy.id }"
  http_method   = "ANY"
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "request_method_integration" {

  rest_api_id = "${aws_api_gateway_rest_api.proxy_public_api.id}"
  resource_id = "${aws_api_gateway_resource.proxy_api_resource_proxy.id }"
  http_method = "${aws_api_gateway_method.proxy_request_method.http_method}"
  type        = "AWS_PROXY"
  uri         = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${aws_lambda_function.lambda_dummy.function_name}/invocations"

  # AWS lambdas can only be invoked with the POST method
  integration_http_method = "POST"

}

resource "aws_lambda_permission" "allow_api_gateway" {

  function_name = "${aws_lambda_function.lambda_dummy.function_name}"
  statement_id  = "AllowExecutionFromApiGateway_${aws_api_gateway_rest_api.proxy_public_api.id}_${aws_api_gateway_resource.proxy_api_resource_proxy.id}"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.proxy_public_api.id}/*/*"

}

resource "aws_api_gateway_resource" "proxy_api_resource_proxy" {

  rest_api_id = "${aws_api_gateway_rest_api.proxy_public_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.proxy_public_api.root_resource_id}"

  path_part   = "{proxy+}"

}

resource "aws_api_gateway_method_response" "200" {

  depends_on = ["aws_api_gateway_resource.proxy_api_resource_proxy","aws_api_gateway_method.proxy_request_method"]

  rest_api_id = "${aws_api_gateway_rest_api.proxy_public_api.id}"
  resource_id = "${aws_api_gateway_resource.proxy_api_resource_proxy.id}"
  http_method = "ANY"
  status_code = "200"

}

resource "aws_api_gateway_integration_response" "proxy_api_integration_response" {

  depends_on = ["aws_api_gateway_integration.request_method_integration","aws_lambda_permission.allow_api_gateway"]

  rest_api_id = "${aws_api_gateway_rest_api.proxy_public_api.id}"
  resource_id = "${aws_api_gateway_resource.proxy_api_resource_proxy.id}"
  http_method = "ANY"
  status_code = "${aws_api_gateway_method_response.200.status_code}"

}
