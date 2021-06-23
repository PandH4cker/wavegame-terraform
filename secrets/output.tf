output "db_creds" {
  value = jsondecode(
      data.aws_secretsmanager_secret_version.creds.secret_string
  )
}