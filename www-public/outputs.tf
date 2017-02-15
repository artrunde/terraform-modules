# ---------------------------------------------------------------------------------------------------------------------
# OUTPUT VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

output "bucket_html_domain_name" {
  value = "${aws_s3_bucket.www-public-html.bucket_domain_name}"
}

output "bucket_assets_domain_name" {
  value = "${aws_s3_bucket.www-public-assets.bucket_domain_name}"
}