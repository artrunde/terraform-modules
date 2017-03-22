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
}

variable "api_id" {
  description = "AWS API Gateway ID"
}

variable "root_resource_id" {
  description = "root_resource_id"
}

variable "resource_path" {
  description = "Resource path e.g /users"
}