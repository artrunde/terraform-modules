# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

# Filename for autodeploy
output "bucket_arn" {
  value = "${aws_s3_bucket.lambda-deploy-bucket.arn}"
}