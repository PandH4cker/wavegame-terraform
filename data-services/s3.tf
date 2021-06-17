# S3 bucket to store application code
resource "aws_s3_bucket" "this" {
  acl    = "private"
  tags = {
    Name = "Application code bucket"
  }
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