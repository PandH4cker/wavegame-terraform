# Security Groups
output "allow_tls_sg_id" {
  value = aws_security_group.allow_tls.id
}

output "allow_http_sg_id" {
  value = aws_security_group.allow_http.id
}

output "allow_ssh_sg_id" {
  value = aws_security_group.allow_ssh.id
}

output "allow_mssql_sg_id" {
  value = aws_security_group.allow_mssql.id
}

output "allow_mysql_sg_id" {
  value = aws_security_group.allow_mysql.id
}

output "allow_icmp_sg_id" {
  value = aws_security_group.allow_icmp.id
}

/* output "main_security_group_id" {
  value = aws_security_group.this.id
} */

# Subnets
output "public_subnet_id" {
  value = aws_subnet.public.id
}
output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}