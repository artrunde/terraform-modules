# ------------------------------------------------------------------------------
# GET DNS ZONE INFOMATION
# ------------------------------------------------------------------------------

data "aws_route53_zone" "root-domain" {
  name = "${var.root_domain}"
  private_zone = false
}

# ------------------------------------------------------------------------------
# CONFIGURE DNS FOR S3 BUCKETS
# ------------------------------------------------------------------------------

resource "aws_route53_record" "s3-website-dns-record" {

  count = "${1 - var.create_cdn}" // Dont create alias record if CDN is used

  zone_id = "${data.aws_route53_zone.root-domain.zone_id}"
  name    = "${var.alias_record}"
  type    = "A"

  alias {
    name    = "${aws_s3_bucket.s3-website.website_domain}"
    zone_id = "${aws_s3_bucket.s3-website.hosted_zone_id}"
    evaluate_target_health = true
  }

}

# ------------------------------------------------------------------------------
# CONFIGURE DNS FOR CDN ASSETS DIST.
# ------------------------------------------------------------------------------

resource "aws_route53_record" "cdn_assets" {

  count = "${var.create_cdn}" // Create alias if CDN set to true

  zone_id = "${data.aws_route53_zone.root-domain.zone_id}"
  name    = "${var.alias_record}"
  type    = "A"

  alias {
    name    = "${aws_cloudfront_distribution.cdn_distribution.domain_name}"
    zone_id = "${aws_cloudfront_distribution.cdn_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}