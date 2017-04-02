# ------------------------------------------------------------------------------
# LAMBDA AUTO DEPLOY UPLOIAD BUCKET
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "lambda-deploy-bucket" {

  bucket        = "${var.bucket_name}"
  acl           = "authenticated-read"
  force_destroy = true

  tags {
    "env"   = "${var.env}"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {

  bucket = "${aws_s3_bucket.lambda-deploy-bucket.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.lambda-deploy.arn}"
    events = ["s3:ObjectCreated:*"]
  }
}