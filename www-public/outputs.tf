# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------
output "s3_www_website_endpoint" {
  value = "${aws_s3_bucket.www-public.website_endpoint}"
}

output "s3_assets_website_endpoint" {
  value = "${aws_s3_bucket.www-public-assets.website_endpoint}"
}

output "s3_www_bucket_domain_name" {
  value = "${aws_s3_bucket.www-public.bucket_domain_name}"
}

output "s3_assets_bucket_domain_name" {
  value = "${aws_s3_bucket.www-public-assets.bucket_domain_name}"
}

output "s3_www_bucket_id" {
  value = "${aws_s3_bucket.www-public.id}"
}

output "s3_assets_bucket_id" {
  value = "${aws_s3_bucket.www-public-assets.id}"
}