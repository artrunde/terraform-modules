# ------------------------------------------------------------------------------
# CONFIGURE CLOUDFRONT DISTRIBUTION
# ------------------------------------------------------------------------------

resource "aws_cloudfront_origin_access_identity" "origin_identity" {

  count = "${var.create_cdn}" // Create CDN if set to true

  comment = "Origin identity"
}

resource "aws_cloudfront_distribution" "cdn_distribution" {

  count = "${var.create_cdn}" // Create CDN if set to true

  origin {

    domain_name = "${aws_s3_bucket.s3-website.bucket_domain_name}"
    origin_id   = "${aws_cloudfront_origin_access_identity.origin_identity.id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_identity.cloudfront_access_identity_path}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront assets distribution"
  default_root_object = "index.html"

  aliases = ["${var.alias_record}.${var.root_domain}"] // FQDN for asset bucket alias

  default_cache_behavior {

    allowed_methods  = ["GET", "OPTIONS", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_cloudfront_origin_access_identity.origin_identity.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = "${var.cdn_cache_min_ttl}"
    default_ttl            = "${var.cdn_cache_default_ttl}"
    max_ttl                = "${var.cdn_cache_max_ttl}"

  }

  price_class = "${var.price_class}"

  tags {
    env   = "${var.env}"
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    acm_certificate_arn             = "${var.cdn_acm_certificate_arn}"
    ssl_support_method              = "sni-only"
    minimum_protocol_version        = "TLSv1"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}