# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

# Filename for autodeploy
output "auto_deployment_filename" {
  value = "${aws_lambda_function.lambda-dummy.function_name}.zip"
}