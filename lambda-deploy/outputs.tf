# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

# Filename for autodeploy
output "bucket_arn" {
  value = "${aws_s3_bucket.lambda-deploy-bucket.arn}"
}

# Filename for autodeploy
output "auto_deploy_bucket_name" {
  value = "${aws_s3_bucket.lambda-deploy-bucket.bucket}"
}