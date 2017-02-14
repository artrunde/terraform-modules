# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket" {
  description = "The name for the S3 bucket"
}

variable "cache_max_age" {
  description = "HTTP header max-age for caching"
  default     = 86400
}

variable "acl" {
  description = "The name of the bucket for assets"
  default     = "public-read"
}

variable "name" {
  description = "Used for the tag 'name'"
}

variable "env" {
  description = "Used for the tag 'env'"
}
