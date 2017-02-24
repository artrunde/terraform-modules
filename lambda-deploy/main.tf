# ------------------------------------------------------------------------------
# LAMBDA FUNCTIONS
# ------------------------------------------------------------------------------
resource "aws_lambda_function" "lambda-s3-deploy" {

  s3_bucket     = "${var.bucket_name}",
  s3_key        = "${var.name}_${var.handler}.zip"

  function_name = "${var.name}_${var.handler}"
  role          = "${var.role}"
  handler       = "${var.name}.${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"

}