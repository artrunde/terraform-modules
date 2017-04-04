# ------------------------------------------------------------------------------
# LAMBDA AUTO DEPLOY UPLOIAD BUCKET
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "lambda_deploy_bucket" {

  bucket        = "${var.bucket_name}"
  acl           = "authenticated-read"
  force_destroy = true

  tags {
    "env"   = "${var.env}"
  }

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": ["arn:aws:iam::${var.account_id}:user/${var.s3_user}"]
      },
      "Action": "s3:*",
      "Resource": ["arn:aws:s3:::${var.bucket_name}",
                   "arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_notification" "bucket_notification" {

  bucket = "${aws_s3_bucket.lambda_deploy_bucket.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.lambda-deploy.arn}"
    events = ["s3:ObjectCreated:*"]
  }
}