# ------------------------------------------------------------------------------
# VARS LAMBDA
# ------------------------------------------------------------------------------

variable "domain_name" {
  description = "dns domain"
}

variable "api_version_map" {
  description = "Map of { version = \"api_id:stage_name\" }"
  type = "map"
}