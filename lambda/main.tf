# ------------------------------------------------------------------------------
# LAMBDA FUNCTIONS
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "lambda-dummy" {

  count = "${var.create_dummy}" // Create simple hello world function

  filename      = "${path.module}/dummy-${var.runtime}.zip"
  function_name = "${var.name}_${var.env}"
  role          = "${var.role}"
  handler       = "index.${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"

}

resource "aws_lambda_function" "lambda" {

  count = "${1 - var.create_dummy}" // Create with a filename

  filename      = "${var.filename}"
  function_name = "${var.name}-${var.env}"
  role          = "${var.role}"
  handler       = "index.${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"

}