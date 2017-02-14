# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN S3 BUCKETS FOR STATIC WEBSITES. ONE FOR HTML AND ONE FOR ASSETS
# ---------------------------------------------------------------------------------------------------------------------
// Public root domain. e.g. artrunde.com
resource "aws_s3_bucket" "www-public-root" {

  bucket        = "${var.bucket}"

  tags {
    "name"  = "${var.name}"
    "env"   = "${var.env}"
  }

  website {
    redirect_all_requests_to = "${var.redirect_all_to}"
  }

}



