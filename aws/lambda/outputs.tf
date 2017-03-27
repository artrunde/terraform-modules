# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

# Filename for autodeploy
output "auto_deployment_filename" {
  value = "${aws_lambda_function.lambda-dummy.function_name}.zip"
}

# Function name
output "function_name" {
  value = "${aws_lambda_function.lambda-dummy.function_name}"
}