# ------------------------------------------------------------------------------
# VARS LAMBDA
# ------------------------------------------------------------------------------

variable "name" {
  description = "The name of the lambda to create, which also defines (i) the archive name (.zip), (ii) the file name, and (iii) the function name"
}

variable "runtime" {
  description = "The runtime of the lambda to create"
  default     = "nodejs"
}

variable "memory_size" {
  description = "Memory assigned for Lambda function"
  default     = "128"
}

variable "handler" {
  description = "The handler name of the lambda (a function defined in your lambda)"
  default     = "handler"
}

variable "role" {
  description = "IAM role attached to the Lambda Function (ARN)"
}

variable "upload_with_s3" {
  description = "true/false if Lambda function should use bucket for fileupload"
  default = false
}

variable "env" {
  description = "Environment tag"
}

variable "bucket_name" {
  description = "Name and path for Lambda S3 upload bucket"
}