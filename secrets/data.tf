data "aws_secretsmanager_secret" "db_master_secret" {
  arn = aws_secretsmanager_secret.db_master_secret.arn
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.db_master_secret.arn

  depends_on = [
    data.aws_secretsmanager_secret.db_master_secret
  ]
}