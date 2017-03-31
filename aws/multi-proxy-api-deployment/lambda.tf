# ------------------------------------------------------------------------------
# LAMBDA FUNCTIONS
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "lambda_dummy" {

  count = "${var.api_count}"

  filename      = "${path.module}/dummy-nodejs4.3.zip"
  function_name = "${var.namespace}_php_lambda_proxy_${var.terra_env}_${count.index}"
  role          = "${aws_iam_role.rodin_role_lambda.arn}"
  handler       = "index.handler"
  runtime       = "nodejs4.3"
  memory_size   = 1536

}