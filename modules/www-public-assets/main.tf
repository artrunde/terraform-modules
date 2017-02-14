# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN S3 BUCKETS FOR STATIC WEBSITES. ONE FOR HTML AND ONE FOR ASSETS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "www-public-assets" {

  bucket        = "${var.bucket}"
  acl           = "${var.acl}"
  force_destroy = true

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
    max_age_seconds = "${var.cache_max_age}"
  }

  tags {
    "name"  = "${var.name}"
    "env"   = "${var.env}"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  policy = "${file("www-public-assets-policy.json")}" // This should always be relative to the env path

}

