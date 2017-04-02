# ------------------------------------------------------------------------------
# VARS LAMBDA
# ------------------------------------------------------------------------------

variable "domain_name" {
  description = "dns domain"
}

variable "stage_map" {
  description = "List of APIs"
  type = "map"
}

variable "active_stage" {
  description = "Name of active stage"
}

variable "version" {
  description = "E.g v1,v2..."
}