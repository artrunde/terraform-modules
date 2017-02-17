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
  description = "The name for the assets S3 bucket. e.g. assets.artrunde.com. This will also be used as alias for a CDN"
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

variable "alias_record_assets" {
  description = "Used for new asset record"
}

variable "alias_record_www" {
  description = "Used for new www record"
}

# ---------------------------------------------------------------------------------------------------------------------
# CDN - ASSETS - OPTIONAL
# ---------------------------------------------------------------------------------------------------------------------

variable "cdn_assets_name" {
  description = "Used for the tag 'name'"
}

variable "cdn_assets_acm_certificate_arn" {
  description = "AWS certificate arn fro CDN"
  type = "string"
  default = "arn:aws:acm:us-east-1:401237329133:certificate/890f1dd0-214f-48ab-a600-0e49942fbde5"
}

variable "create_cdn_assets" {
  description = "If set to true, create an CDN for the S3 bucket"
}

variable "cdn_assets_cache_min_ttl" {
  description = "Minimum TTL for cache"
  default = 3600
}

variable "cdn_assets_cache_default_ttl" {
  description = "Default TTL for cache"
  default = 86400
}

variable "cdn_assets_cache_max_ttl" {
  description = "Maximum TTL for cache"
  default = 86400
}

# ---------------------------------------------------------------------------------------------------------------------
# CDN - WWW - OPTIONAL
# ---------------------------------------------------------------------------------------------------------------------

variable "cdn_www_name" {
  description = "Used for the tag 'name'"
}

variable "cdn_www_acm_certificate_arn" {
  description = "AWS certificate arn fro CDN"
  type = "string"
  default = "arn:aws:acm:us-east-1:401237329133:certificate/890f1dd0-214f-48ab-a600-0e49942fbde5"
}

variable "create_cdn_www" {
  description = "If set to true, create an CDN for the www S3 bucket"
}

variable "cdn_www_cache_min_ttl" {
  description = "Minimum TTL for cache"
  default = 3600
}

variable "cdn_www_cache_default_ttl" {
  description = "Default TTL for cache"
  default = 86400
}

variable "cdn_www_cache_max_ttl" {
  description = "Maximum TTL for cache"
  default = 86400
}

# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT
# ---------------------------------------------------------------------------------------------------------------------

variable "env" {
  description = "Used for the tag 'env'"
}
