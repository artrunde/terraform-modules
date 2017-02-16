# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN S3 BUCKETS FOR STATIC WEBSITES, HTML AND ONE FOR ROOT DOMAIN
# ---------------------------------------------------------------------------------------------------------------------

// Public domain html. e.g. www.artrunde.com
resource "aws_s3_bucket" "www-public-html" {

  bucket        = "${var.bucket_html}"
  acl           = "${var.acl_html}"
  force_destroy = true

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
    max_age_seconds = "${var.cache_max_age_html}"
  }

  tags {
    "name"  = "${var.name_html}"
    "env"   = "${var.env}"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.www-public-logs.id}"
    target_prefix = "${var.bucket_html}-"
  }

  policy = "${file("www-public-html-policy.json")}" // This should always be relative to the env path

}

// Public domain assets. e.g. assets.artrunde.com
resource "aws_s3_bucket" "www-public-assets" {

  bucket        = "${var.bucket_assets}"
  acl           = "${var.acl_assets}"
  force_destroy = true

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
    max_age_seconds = "${var.cache_max_age_assets}"
  }

  tags {
    "name"  = "${var.name_assets}"
    "env"   = "${var.env}"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.www-public-logs.id}"
    target_prefix = "${var.bucket_assets}-"
  }

  policy = "${file("www-public-assets-policy.json")}" // This should always be relative to the env path

}

# ------------------------------------------------------------------------------
# S3 LOG BUCKET
# ------------------------------------------------------------------------------

// Log bucket. Should not be destroyed. But redeployed under new name when apply
resource "aws_s3_bucket" "www-public-logs" {

  bucket        = "www-public-logs-artrunde-${random_id.www-public-logs.hex}"
  force_destroy = false
  acl           = "log-delivery-write"

  tags {
    "name"  = "www-public-logs"
    "env"   = "${var.env}"
  }
}

# ------------------------------------------------------------------------------
# USED FOR RANDOM NAMING
# ------------------------------------------------------------------------------

resource "random_id" "www-public-logs" {
  byte_length = 8
}

# ------------------------------------------------------------------------------
# GET DNS ZONE INFOMRATION
# ------------------------------------------------------------------------------

data "aws_route53_zone" "primary" {
  name = "artrunde.com."
  private_zone = false
}

# ------------------------------------------------------------------------------
# CONFIGURE DNS FOR S3 BUCKETS
# ------------------------------------------------------------------------------

resource "aws_route53_record" "assets" {

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name = "${var.record_assets}"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www-public-assets.website_domain}"
    zone_id = "${aws_s3_bucket.www-public-assets.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name = "${var.record_www}"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www-public-html.website_domain}"
    zone_id = "${aws_s3_bucket.www-public-html.hosted_zone_id}"
    evaluate_target_health = true
  }

}

