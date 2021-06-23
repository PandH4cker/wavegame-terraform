# MYSQL Logs
output "cloudwatch_event_rule_name_mysql" {
  value = aws_cloudwatch_event_rule.rds_mysql_logs_to_s3.name
}
output "cloudwatch_event_rule_arn_mysql" {
  value = aws_cloudwatch_event_rule.rds_mysql_logs_to_s3.arn
}
output "cloudwatch_event_target_id_mysql" {
  value = aws_cloudwatch_event_target.rds_mysql_logs_to_s3.id
}
output "cloudwatch_event_target_arn_mysql" {
  value = aws_cloudwatch_event_target.rds_mysql_logs_to_s3.arn
}
output "allow_cloudwatch_lambda_permission_id_mysql" {
  value = aws_lambda_permission.allow_cloudwatch_mysql.id
}

# MSSQL Logs
output "cloudwatch_event_rule_name_mssql" {
  value = aws_cloudwatch_event_rule.rds_mssql_logs_to_s3.name
}
output "cloudwatch_event_rule_arn_mssql" {
  value = aws_cloudwatch_event_rule.rds_mssql_logs_to_s3.arn
}
output "cloudwatch_event_target_id_mssql" {
  value = aws_cloudwatch_event_target.rds_mssql_logs_to_s3.id
}
output "cloudwatch_event_target_arn_mssql" {
  value = aws_cloudwatch_event_target.rds_mssql_logs_to_s3.arn
}
output "allow_cloudwatch_lambda_permission_id_mssql" {
  value = aws_lambda_permission.allow_cloudwatch_mssql.id
}