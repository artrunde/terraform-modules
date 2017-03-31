# ------------------------------------------------------------------------------
# DALI APIs - API
# ------------------------------------------------------------------------------

resource "aws_api_gateway_rest_api" "rodin_proxy_public_api" {

  count = "${var.api_count}"

  name = "${var.namespace}_${var.terra_env}_${count.index}"
}

# ------------------------------------------------------------------------------
# DALI API - DEPLOYMENTS
# ------------------------------------------------------------------------------

resource "aws_api_gateway_deployment" "proxy_public_api_deployment" {

  count = "${var.api_count}"

  depends_on  = ["aws_api_gateway_integration_response.proxy_api_integration_response","aws_api_gateway_method.proxy_request_method","aws_api_gateway_method_response.200"]
  rest_api_id = "${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}"
  stage_name  = "${count.index}"

}

resource "aws_api_gateway_method" "proxy_request_method" {

  count = "${var.api_count}"

  rest_api_id   = "${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}"
  resource_id   = "${element(aws_api_gateway_resource.proxy_api_resource_proxy.*.id, count.index) }"
  http_method   = "ANY"
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "request_method_integration" {

  count = "${var.api_count}"

  rest_api_id = "${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}"
  resource_id = "${element(aws_api_gateway_resource.proxy_api_resource_proxy.*.id, count.index) }"
  http_method = "${element(aws_api_gateway_method.proxy_request_method.*.http_method, count.index)}"
  type        = "AWS_PROXY"
  uri         = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${element(aws_lambda_function.lambda_dummy.*.function_name, count.index)}/invocations"

  # AWS lambdas can only be invoked with the POST method
  integration_http_method = "POST"

}

resource "aws_lambda_permission" "allow_api_gateway" {

  count = "${var.api_count}"

  function_name = "${element(aws_lambda_function.lambda_dummy.*.function_name, count.index)}"
  statement_id  = "AllowExecutionFromApiGateway_${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}_${element(aws_api_gateway_resource.proxy_api_resource_proxy.*.id, count.index)}"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}/*/*"

}

resource "aws_api_gateway_resource" "proxy_api_resource_proxy" {

  count = "${var.api_count}"

  // rest_api_id = "${aws_api_gateway_rest_api.rodin_proxy_public_api.id}"
  // parent_id   = "${aws_api_gateway_resource.proxy_api_resource.id}"

  rest_api_id = "${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}"
  parent_id   = "${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.root_resource_id, count.index)}"

  path_part   = "{proxy+}"

}

resource "aws_api_gateway_method_response" "200" {

  count = "${var.api_count}"

  depends_on = ["aws_api_gateway_resource.proxy_api_resource_proxy","aws_api_gateway_method.proxy_request_method"]

  rest_api_id = "${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}"
  resource_id = "${element(aws_api_gateway_resource.proxy_api_resource_proxy.*.id, count.index)}"
  http_method = "ANY"
  status_code = "200"

}

resource "aws_api_gateway_integration_response" "proxy_api_integration_response" {

  count = "${var.api_count}"

  depends_on = ["aws_api_gateway_integration.request_method_integration","aws_lambda_permission.allow_api_gateway"]

  rest_api_id = "${element(aws_api_gateway_rest_api.rodin_proxy_public_api.*.id, count.index)}"
  resource_id = "${element(aws_api_gateway_resource.proxy_api_resource_proxy.*.id, count.index)}"
  http_method = "ANY"
  status_code = "${element(aws_api_gateway_method_response.200.*.status_code,count.index)}"

}
