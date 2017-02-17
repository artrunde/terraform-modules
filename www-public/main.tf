# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN S3 BUCKETS FOR STATIC WEBSITES, HTML AND ONE FOR ROOT DOMAIN
# ---------------------------------------------------------------------------------------------------------------------

// Public domain www. e.g. www.artrunde.com
resource "aws_s3_bucket" "www-public" {

  bucket        = "${var.bucket_www}"
  acl           = "${var.acl_www}"
  force_destroy = true

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = "${var.cache_max_age_www}"
  }

  tags {
    "name"  = "${var.name_www}"
    "env"   = "${var.env}"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.www-public-logs.id}"
    target_prefix = "${var.bucket_www}-"
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
    expose_headers  = ["ETag"]
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

  count = "${1 - var.create_cdn_assets}" // Dont create alias record if CDN is used

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name = "${var.alias_record_assets}"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www-public-assets.website_domain}"
    zone_id = "${aws_s3_bucket.www-public-assets.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name = "${var.alias_record_www}"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www-public.website_domain}"
    zone_id = "${aws_s3_bucket.www-public.hosted_zone_id}"
    evaluate_target_health = true
  }

}

# ------------------------------------------------------------------------------
# CONFIGURE CLOUDFRONT DISTRIBUTION FOR ASSETS
# ------------------------------------------------------------------------------

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Asset origin identity"
}

resource "aws_cloudfront_distribution" "assets_distribution" {

  count = "${var.create_cdn_assets}" // Create CDN if set to true

  origin {

    domain_name = "${aws_s3_bucket.www-public-assets.bucket_domain_name}"
    origin_id   = "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront assets distribution"
  default_root_object = "index.html"

  aliases = ["${var.bucket_assets}"] // FQDN for asset bucket alias

  default_cache_behavior {

    allowed_methods  = ["GET", "OPTIONS", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = "${var.cdn_assets_cache_min_ttl}"
    default_ttl            = "${var.cdn_assets_cache_default_ttl}"
    max_ttl                = "${var.cdn_assets_cache_max_ttl}"

  }

  price_class = "PriceClass_100" // Lowest

  tags {
    name  = "${var.cdn_assets_name}"
    env   = "${var.env}"
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    acm_certificate_arn             = "${var.cdn_assets_acm_certificate_arn}"
    ssl_support_method              = "sni-only"
    minimum_protocol_version        = "TLSv1"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

# ------------------------------------------------------------------------------
# CONFIGURE DNS FOR CDN ASSETS DIST.
# ------------------------------------------------------------------------------

resource "aws_route53_record" "cdn_assets" {

  count = "${var.create_cdn_assets}" // Create alias if CDN set to true

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name = "${var.alias_record_assets}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.assets_distribution.domain_name}"
    zone_id = "${aws_cloudfront_distribution.assets_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}



# ------------------------------------------------------------------------------
# CONFIGURE CLOUDFRONT DISTRIBUTION FOR WWW
# ------------------------------------------------------------------------------

resource "aws_cloudfront_origin_access_identity" "www_origin_access_identity" {
  comment = "www origin identity"
}

resource "aws_cloudfront_distribution" "www_distribution" {

  count = "${var.create_cdn_www}" // Create CDN if set to true

  origin {

    domain_name = "${aws_s3_bucket.www-public.bucket_domain_name}"
    origin_id   = "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront www distribution"
  default_root_object = "index.html"

  aliases = ["${var.bucket_www}"] // FQDN for www bucket alias

  default_cache_behavior {

    allowed_methods  = ["GET", "OPTIONS", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = "${var.cdn_www_cache_min_ttl}"
    default_ttl            = "${var.cdn_www_cache_default_ttl}"
    max_ttl                = "${var.cdn_www_cache_max_ttl}"

  }

  price_class = "PriceClass_100" // Lowest

  tags {
    name  = "${var.cdn_www_name}"
    env   = "${var.env}"
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    acm_certificate_arn             = "${var.cdn_www_acm_certificate_arn}"
    ssl_support_method              = "sni-only"
    minimum_protocol_version        = "TLSv1"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

# ------------------------------------------------------------------------------
# CONFIGURE DNS FOR CDN DIST.
# ------------------------------------------------------------------------------

resource "aws_route53_record" "cdn_www" {

  count = "${var.create_cdn_www}" // Create alias if CDN set to true

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name = "${var.alias_record_www}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.www_distribution.domain_name}"
    zone_id = "${aws_cloudfront_distribution.www_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}

