# ---------------------------------------------------------------------------------------------------------------------
# S3 BUCKET
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket_name" {
  description = "The name for the www s3 bucket"
}

variable "cache_max_age" {
  description = "HTTP header max-age for caching"
  default     = 300
}

variable "acl" {
  description = "The permission of the bucket for www"
  default     = "public-read"
}

variable "create_log" {
  description = "Create log bucket for s3 website"
  default = true
}

# ---------------------------------------------------------------------------------------------------------------------
# DNS - IS NOT USED WHEN USING CDN
# ---------------------------------------------------------------------------------------------------------------------

variable "root_domain" {
  description = "DNS root domain used for alias records"
}

variable "alias_record" {
  description = "Used for new asset record"
}

# ---------------------------------------------------------------------------------------------------------------------
# CDN - OPTIONAL
# ---------------------------------------------------------------------------------------------------------------------

variable "cdn_acm_certificate_arn" {
  description = "AWS certificate arn for CDN"
  type        = "string"
}

variable "price_class" {
  description = "CDN price class"
  default     = "PriceClass_100" // Lowest
}

variable "create_cdn" {
  description = "If set to true, create an CDN for the S3 bucket"
}

variable "cdn_cache_min_ttl" {
  description = "Minimum TTL for cache"
  default     = 3600
}

variable "cdn_cache_default_ttl" {
  description = "Default TTL for cache"
  default     = 86400
}

variable "cdn_cache_max_ttl" {
  description = "Maximum TTL for cache"
  default     = 86400
}

# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT
# ---------------------------------------------------------------------------------------------------------------------

variable "env" {
  description = "Used for the tag 'env'"
}