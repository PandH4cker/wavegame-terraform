output "first_elb_dns_name" {
  value = aws_elb.first.dns_name
}
output "second_elb_dns_name" {
  value = aws_elb.second.dns_name
}