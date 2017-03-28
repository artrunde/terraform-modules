resource "aws_api_gateway_method" "proxy_request_method" {

  rest_api_id   = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.proxy_api_resource.id}"
  http_method   = "ANY"
  authorization = "${var.authorization}"

}

resource "aws_api_gateway_integration" "request_method_integration" {

  rest_api_id = "${var.api_id}"
  resource_id = "${aws_api_gateway_resource.proxy_api_resource.id}"
  http_method = "${aws_api_gateway_method.proxy_request_method.http_method}"
  type        = "AWS_PROXY"
  uri         = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${var.lambda}/invocations"

  # AWS lambdas can only be invoked with the POST method
  integration_http_method = "POST"

}

resource "aws_lambda_permission" "allow_api_gateway" {

  function_name = "${var.lambda}"
  statement_id  = "AllowExecutionFromApiGateway_${var.api_id}_${aws_api_gateway_resource.proxy_api_resource_proxy.id}"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.api_id}/*/*"

}

resource "aws_api_gateway_resource" "proxy_api_resource" {
  rest_api_id = "${var.api_id}"
  parent_id   = "${var.root_resource_id}"
  path_part   = "${var.resource_path}"
}

resource "aws_api_gateway_resource" "proxy_api_resource_proxy" {
  rest_api_id = "${var.api_id}"
  parent_id   = "${aws_api_gateway_resource.proxy_api_resource.id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method_response" "200" {
  depends_on = ["aws_api_gateway_resource.proxy_api_resource_proxy","aws_api_gateway_resource.proxy_api_resource"]
  rest_api_id = "${var.api_id}"
  resource_id = "${aws_api_gateway_resource.proxy_api_resource.id}"
  http_method = "ANY"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "proxy_api_integration_response" {
  depends_on = ["aws_api_gateway_integration.request_method_integration","aws_lambda_permission.allow_api_gateway"]
  rest_api_id = "${var.api_id}"
  resource_id = "${aws_api_gateway_resource.proxy_api_resource.id}"
  http_method = "ANY"
  status_code = "${aws_api_gateway_method_response.200.status_code}"
}
