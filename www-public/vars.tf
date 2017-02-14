# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket_html" {
  description = "The name for the S3 bucket"
}

variable "bucket_assets" {
  description = "The name for the S3 bucket"
}

variable "bucket_root" {
  description = "The name for the S3 bucket"
}


variable "cache_max_age_html" {
  description = "HTTP header max-age for caching"
  default     = 300
}

variable "cache_max_age_assets" {
  description = "HTTP header max-age for caching"
  default     = 86400
}

variable "acl_html" {
  description = "The name of the bucket for assets"
  default     = "public-read"
}

variable "acl_assets" {
  description = "The name of the bucket for assets"
  default     = "public-read"
}

variable "name_html" {
  description = "Used for the tag 'name'"
}

variable "name_assets" {
  description = "Used for the tag 'name'"
}

variable "name_root" {
  description = "Used for the tag 'name'"
}

variable "redirect_all_to" {
  description = "Protocal and host to redirect all requests to. E.g https://www.artrunde.com"
}

variable "env" {
  description = "Used for the tag 'env'"
}
