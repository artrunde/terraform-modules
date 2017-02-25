# ------------------------------------------------------------------------------
# VARS LAMBDA
# ------------------------------------------------------------------------------

variable "name" {
  description = "The name of the lambda to create, which also defines (i) the archive name (.zip), (ii) the file name, and (iii) the function name"
}

variable "create_dummy" {
  description = "Weather or not to create an lambda function with simple Hello World example"
  default = true
}

variable "filename" {
  description = "Filename for Lambda function"
  default = "filename.zip"
}

variable "runtime" {
  description = "The runtime of the lambda to create"
  default     = "nodejs4.3"
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

variable "env" {
  description = "Environment tag"
}