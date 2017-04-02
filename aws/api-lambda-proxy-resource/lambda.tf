# ------------------------------------------------------------------------------
# LAMBDA FUNCTIONS
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "lambda_dummy" {

  filename      = "${path.module}/dummy-nodejs4.3.zip"
  function_name = "${var.namespace}_${var.api_version}_${var.stage_name}_${var.terra_env}"
  role          = "${var.role_lambda_arn}"
  handler       = "index.handler"
  runtime       = "nodejs4.3"
  memory_size   = 1536

}