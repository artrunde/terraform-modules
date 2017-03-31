resource "aws_iam_role_policy_attachment" "rodin_role_attach_policy" {
  role        = "${aws_iam_role.rodin_role_lambda.name}"
  policy_arn  = "${aws_iam_policy.rodin_policy_lambda.arn}"
}

resource "aws_iam_policy" "rodin_policy_lambda" {

  name = "${var.namespace}_policy_lambda_${var.terra_env}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AccessCloudwatchLogs",
      "Action": ["logs:*"],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:Query",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:Scan"
        ],
      "Resource": "arn:aws:dynamodb:${var.region}:${var.account_id}:table/${var.namespace}_*_${var.terra_env}"
    }
   ]
}
EOF
}

resource "aws_iam_role" "rodin_role_lambda" {

  name = "${var.namespace}_role_lambda_${var.terra_env}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
