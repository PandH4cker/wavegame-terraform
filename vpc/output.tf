output "main_security_group_id" {
  value = aws_security_group.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}
output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}