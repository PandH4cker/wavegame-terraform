output "lambda_function_arn" {
  value = aws_lambda_function.rds_logs_to_s3.arn
}
output "lambda_function_name" {
  value = aws_lambda_function.rds_logs_to_s3.function_name
}