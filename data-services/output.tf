output "application_code_bucket_id" {
  value = aws_s3_bucket.this.id
}

output "application_code_bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "application_code_1_object" {
  value = {
    "id"   = aws_s3_bucket_object.application_code_1.id
    "etag" = aws_s3_bucket_object.application_code_1.etag
  }
}
output "application_code_2_object" {
  value = {
    "id"   = aws_s3_bucket_object.application_code_2.id
    "etag" = aws_s3_bucket_object.application_code_2.etag
  }
}

output "first_rds_endpoint" {
  value = aws_db_instance.first.endpoint
}
output "second_rds_endpoint" {
  value = aws_db_instance.second.endpoint
}