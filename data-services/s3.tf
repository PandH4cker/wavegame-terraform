# S3 bucket to store application code
resource "aws_s3_bucket" "this" {
  acl    = "private"
  tags = {
    Name = "Application code bucket"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "log-bucket-first"
  acl    = "log-delivery-write"
  tags = {
    Name = "Log bucket"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true
}

data "aws_elb_service_account" "main" {}
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "lb-bucket-policy" {
  bucket = aws_s3_bucket.log_bucket.id
  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      },
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "${aws_s3_bucket.log_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "${aws_s3_bucket.log_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": [
        "s3:GetBucketAcl"
      ],
      "Resource": "${aws_s3_bucket.log_bucket.arn}"
    }
  ]
}
  POLICY
}

resource "aws_s3_bucket_object" "application_code_1" {
  bucket = aws_s3_bucket.this.id
  key    = "application-1.php"
  source = "${path.module}/application-code/application-1.php"
  etag    = "${filemd5("${path.module}/application-code/application-1.php")}"
}
resource "aws_s3_bucket_object" "application_code_2" {
  bucket = aws_s3_bucket.this.id
  key    = "application-2.php"
  source = "${path.module}/application-code/application-2.php"
  etag    = "${filemd5("${path.module}/application-code/application-2.php")}"
}