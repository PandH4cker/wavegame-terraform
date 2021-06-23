resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "db_master_secret" {
   name = "db-master-secret-first"
   recovery_window_in_days = 0

   lifecycle {
     create_before_destroy = true
   }
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.db_master_secret.id
  secret_string = <<EOF
   {
    "username": "admin",
    "password": "${random_password.password.result}"
   }
EOF
}

