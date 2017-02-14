# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket" {
  description = "The name for the S3 bucket"
}

variable "name" {
  description = "Used for the tag 'name'"
}

variable "env" {
  description = "Used for the tag 'env'"
}

variable "redirect_all_to" {
  description = "Protocal and host to redirect all requests to. E.g https://www.artrunde.com"
}
