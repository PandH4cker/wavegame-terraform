# Instance profile to give permissions to the ec2 instances
resource "aws_iam_role" "ec2" {
  name = "ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    name = "Ec2 role"
  }
}

# Enable S3 access to fetch application code
resource "aws_iam_policy" "s3_list_get_policy" {
  name = "s3-list-get-policy"
  description = "Allow List and Get of S3 Bucket"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "s3:GetObject",
              "s3:GetObjectAcl",
              "s3:ListBucket"
          ],
          "Resource": "${var.application_code_bucket_arn}"
      }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "ec2_s3_list_get" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.s3_list_get_policy.arn
}

# Don't remove
resource "aws_iam_role" "check" {
  name = "check"
  assume_role_policy = data.aws_iam_policy_document.check.json
}
resource "aws_iam_role_policy_attachment" "check" {
  role       = aws_iam_role.check.name
  policy_arn = data.aws_iam_policy.read_only_access.arn
}

# Enable SSM sto connect with shell without opening ssh ports
resource "aws_iam_role_policy_attachment" "SSMPolicyAttach" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2.name
}