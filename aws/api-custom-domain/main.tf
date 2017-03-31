# ------------------------------------------------------------------------------
# DNS FOR CUSTOM DOMAIN NAME
# ------------------------------------------------------------------------------

resource "aws_route53_record" "example" {

  zone_id = "${var.zone_id}"

  name = "${aws_api_gateway_domain_name.api_domain_name.domain_name}"
  type = "A"

  alias {
    name     = "${aws_api_gateway_domain_name.api_domain_name.cloudfront_domain_name}"
    zone_id  = "${aws_api_gateway_domain_name.api_domain_name.cloudfront_zone_id}"
    evaluate_target_health = true
  }

}

# ------------------------------------------------------------------------------
# CUSTOM DOMAIN NAME
# ------------------------------------------------------------------------------

resource "aws_api_gateway_domain_name" "api_domain_name" {

  domain_name       = "${var.domain_name}"
  certificate_arn   = "${var.certificate_arn}"

}