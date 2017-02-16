# ------------------------------------------------------------------------------
# CONFIGURE CLOUDFRONT DISTRIBUTION FOR ASSETS
# ------------------------------------------------------------------------------

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Some comment"
}

resource "aws_cloudfront_distribution" "s3_distribution" {

  origin {

    domain_name = "${var.bucket_domain_name}"
    origin_id   = "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront assets"
  default_root_object = "index.html"

  aliases = "${var.aliases}"

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
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

  }

  price_class = "PriceClass_All"

  tags {
    env = "${var.env}"
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    acm_certificate_arn             = "arn:aws:acm:us-east-1:401237329133:certificate/890f1dd0-214f-48ab-a600-0e49942fbde5"
    ssl_support_method              = "sni-only"
    minimum_protocol_version        = "TLSv1"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
