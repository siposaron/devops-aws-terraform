# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda-exec" {
  name = "serverless_interceptor_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "lambda-role-policy" {
  name   = "lambda-role-policy"
  role   = aws_iam_role.lambda-exec.id
  policy = data.aws_iam_policy_document.lambda-invoke-policy.json
}

data "aws_iam_policy_document" "lambda-invoke-policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["lambda:InvokeFunction"]
    resources = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:*"]
  }
}

