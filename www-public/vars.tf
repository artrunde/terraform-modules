# ---------------------------------------------------------------------------------------------------------------------
# S3 WWW
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket_www" {
  description = "The name for the www S3 bucket"
}

variable "cache_max_age_www" {
  description = "HTTP header max-age for caching"
  default     = 300
}

variable "acl_www" {
  description = "The permission of the bucket for www"
  default     = "public-read"
}

variable "name_www" {
  description = "Used for the tag 'name'"
}

# ---------------------------------------------------------------------------------------------------------------------
# S3 ASSETS
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket_assets" {
  description = "The name for the assets S3 bucket"
}

variable "cache_max_age_assets" {
  description = "HTTP header max-age for caching"
  default     = 86400
}

variable "acl_assets" {
  description = "The permission of the bucket for assets"
  default     = "public-read"
}

variable "name_assets" {
  description = "Used for the tag 'name'"
}

# ---------------------------------------------------------------------------------------------------------------------
# DNS - IS NOT USED WHEN USING CDN
# ---------------------------------------------------------------------------------------------------------------------

variable "record_assets" {
  description = "Used for new asset record"
}

variable "record_www" {
  description = "Used for new www record"
}

# ---------------------------------------------------------------------------------------------------------------------
# CDN - OPTIONAL
# ---------------------------------------------------------------------------------------------------------------------

variable "name_cdn" {
  description = "Used for the tag 'name'"
}

variable "aliases_cdn" {
  description = "Aliases for Cloudfront CDN"
  type = "list"
}

variable "acm_certificate_arn_cdn" {
  description = "AWS certificate arn fro CDN"
  type = "string"
  default = "arn:aws:acm:us-east-1:401237329133:certificate/890f1dd0-214f-48ab-a600-0e49942fbde5"
}

variable "create_cdn" {
  description = "If set to true, create an CDN for the S3 bucket"
}

# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT
# ---------------------------------------------------------------------------------------------------------------------

variable "env" {
  description = "Used for the tag 'env'"
}
