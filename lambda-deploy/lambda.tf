# ------------------------------------------------------------------------------
# LAMBDA AUTO DEPLOY FUNCTION
# ------------------------------------------------------------------------------
resource "aws_lambda_function" "lambda-deploy" {

  filename      = "${path.module}/lambda-deploy.zip"

  function_name = "${var.name}_${var.env}"
  role          = "${var.role}"
  handler       = "index.${var.handler}"
  runtime       = "nodejs4.3"
  memory_size   = "${var.memory_size}"

}

resource "aws_lambda_permission" "allow_bucket" {

  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda-deploy.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.lambda-deploy-bucket.arn}"

}
