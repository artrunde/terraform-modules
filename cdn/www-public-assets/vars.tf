# ---------------------------------------------------------------------------------------------------------------------
# DNS
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket_domain_name" {
  description = "S3 bucket domain name for CDN"
}

variable "aliases" {
  description = "Aliases for Cloudfront CDN"
  type = "list"
}

variable "env" {
  description = "Used for the tag 'env'"
}
