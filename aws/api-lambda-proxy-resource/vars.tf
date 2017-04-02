# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "terra_env" {
  description = "Terraform environment. E.g dev/prd"
}

variable "namespace" {
  description = "Namespace of service"
}

variable "account_id" {
  description = "AWS account number"
}

variable "region" {
  description = "AWS region"
}

variable "stage_name" {
  description = "Stagename to deploy"
}

variable "api_version" {
  description = "E.g v1, v2..."
}

variable "role_lambda_arn" {

}