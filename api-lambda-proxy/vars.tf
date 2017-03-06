# ---------------------------------------------------------------------------------------------------------------------
# VARS
# ---------------------------------------------------------------------------------------------------------------------

variable "lambda" {
  description = "The lambda name to invoke"
}

variable "region" {
  description = "The AWS region, e.g., eu-west-1"
}

variable "account_id" {
  description = "The AWS account ID"
}

variable "authorization" {
  description = "API Gateway endpoint authorization"
  default = "NONE"
}

variable "api_name" {
  description = "Name for API"
}