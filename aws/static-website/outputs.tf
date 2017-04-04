# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------
output "s3_website_endpoint" {
  value = "${aws_s3_bucket.s3-website.website_endpoint}"
}

output "s3_bucket_id" {
  value = "${aws_s3_bucket.s3-website.id}"
}