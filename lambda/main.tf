# ------------------------------------------------------------------------------
# LAMBDA FUNCTIONS
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "lambda-file" {

  count         = "${1 - var.upload_with_s3}"

  filename      = "${var.name}.zip"
  function_name = "${var.name}_${var.handler}"
  role          = "${var.role}"
  handler       = "${var.name}.${var.handler}"
  runtime       = "${var.runtime}"
}

resource "aws_lambda_function" "lambda-s3-upload" {

  count         = "${var.upload_with_s3}"

  s3_bucket     = "${var.bucket_name}"
  s3_key        = "${var.name}_${var.handler}.zip"

  function_name = "${var.name}_${var.handler}"
  role          = "${var.role}"
  handler       = "${var.name}.${var.handler}"
  runtime       = "${var.runtime}"

}

output "name" {
  value = "${aws_lambda_function.lambda-file.function_name}"
}
