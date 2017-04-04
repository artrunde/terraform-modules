# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN S3 BUCKETS FOR STATIC WEBSITES
# ---------------------------------------------------------------------------------------------------------------------

// Public domain www. e.g. www.artrunde.com
resource "aws_s3_bucket" "s3-website" {

  bucket        = "${var.bucket_name}"
  acl           = "${var.acl}"
  force_destroy = true

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = "${var.cache_max_age}"
  }

  tags {
    "env" = "${var.env}"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.s3-website-log.id}"
  }

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
  	{
	  "Sid":"PublicReadGetObject",
	  "Effect":"Allow",
	  "Principal": "*",
	  "Action":["s3:GetObject"],
	  "Resource":["arn:aws:s3:::${var.bucket_name}/*"]
	}
  ]
}
EOF

}

# ------------------------------------------------------------------------------
# USED FOR RANDOM NAMING
# ------------------------------------------------------------------------------

resource "random_id" "log-suffix" {
  byte_length = 8
}

# ------------------------------------------------------------------------------
# S3 LOG BUCKET
# ------------------------------------------------------------------------------

// Log bucket. Should not be destroyed. But redeployed under new name when apply
resource "aws_s3_bucket" "s3-website-log" {

  count         = "${var.create_log}" // Create log bucket if set to true
  bucket        = "${var.bucket_name}-logs-${random_id.log-suffix.hex}"
  force_destroy = true
  acl           = "log-delivery-write"

  tags {
    "env"   = "${var.env}"
  }
  
}
