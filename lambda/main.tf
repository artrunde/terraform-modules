# ------------------------------------------------------------------------------
# LAMBDA FUNCTIONS
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "lambda" {

  filename      = "${path.module}/helloworld.zip"
  function_name = "${var.name}"
  role          = "${var.role}"
  handler       = "index.${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"

}