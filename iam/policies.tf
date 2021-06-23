resource "aws_iam_policy" "subscription_app_policy" {
    name = "subscription-app-policy"
    path = "/"
    description = "Subscription App Access Only"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "ec2:*"
                ]
                Effect = "Allow"
                Resource = "${var.ec2_subscription_app_arn}"
            },
            {
                Action = [
                    "rds:*"
                ]
                Effect = "Allow"
                Resource = "${var.mysql_arn}"
            },
            {
                Action = [
                    "s3:*"
                ]
                Effect = "Allow"
                Resource = "${var.application_code_bucket_arn}"
            }
        ]
    })
}

resource "aws_iam_policy" "stream_app_policy" {
    name = "stream-app-policy"
    path = "/"
    description = "Stream App Access Only"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "ec2:*"
                ]
                Effect = "Allow"
                Resource = "${var.ec2_stream_app_arn}"
            },
            {
                Action = [
                    "rds:*"
                ]
                Effect = "Allow"
                Resource = "${var.mssql_arn}"
            },
            {
                Action = [
                    "s3:*"
                ]
                Effect = "Allow"
                Resource = "${var.application_code_bucket_arn}"
            }
        ]
    })
}