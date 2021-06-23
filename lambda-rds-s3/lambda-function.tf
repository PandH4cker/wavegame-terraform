resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_lambda_function" "rds_logs_to_s3" {
  function_name = "rds_logs_to_s3"
  handler = "rds_logs_to_s3.lambda_handler"
  role = aws_iam_role.iam_for_lambda.arn
  runtime = "python3.7"
  memory_size = var.memory_size
  timeout = var.timeout

  filename = "./lambda-rds-s3/rds_logs_to_s3.zip"
}