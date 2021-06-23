# MYSQL Logs
resource "aws_cloudwatch_event_rule" "rds_mysql_logs_to_s3" {
  name = "rds_logs_to_s3_mysql"
  description = "Triggers moving logs from RDS (mysql) to S3."
  schedule_expression = "rate(${var.rate})"
}

resource "aws_cloudwatch_event_target" "rds_mysql_logs_to_s3" {
  rule = aws_cloudwatch_event_rule.rds_mysql_logs_to_s3.name
  target_id = aws_cloudwatch_event_rule.rds_mysql_logs_to_s3.name
  arn = var.lambda_function_arn
  input = <<INPUT
{
    "s3_bucket_name": "${var.s3_bucket_name}",
    "rds_instance_name": "${var.rds_instance_names[0]}",
    "aws_region": "${var.region}",
    "log_prefix": "${var.log_prefix}",
    "min_size": ${var.min_file_size}
}
INPUT
}

resource "aws_lambda_permission" "allow_cloudwatch_mysql" {
  statement_id = "allow_execution_from_cloudwatch_mysql"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.rds_mysql_logs_to_s3.arn
}

# MSSQL Logs
resource "aws_cloudwatch_event_rule" "rds_mssql_logs_to_s3" {
  name = "rds_logs_to_s3_mssql"
  description = "Triggers moving logs from RDS (mssql) to S3."
  schedule_expression = "rate(${var.rate})"
}

resource "aws_cloudwatch_event_target" "rds_mssql_logs_to_s3" {
  rule = aws_cloudwatch_event_rule.rds_mssql_logs_to_s3.name
  target_id = aws_cloudwatch_event_rule.rds_mssql_logs_to_s3.name
  arn = var.lambda_function_arn
  input = <<INPUT
{
    "s3_bucket_name": "${var.s3_bucket_name}",
    "rds_instance_name": "${var.rds_instance_names[1]}",
    "aws_region": "${var.region}",
    "log_prefix": "${var.log_prefix}",
    "min_size": ${var.min_file_size}
}
INPUT
}

resource "aws_lambda_permission" "allow_cloudwatch_mssql" {
  statement_id = "allow_execution_from_cloudwatch_mssql"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.rds_mssql_logs_to_s3.arn
}