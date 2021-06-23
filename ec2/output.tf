output "main_lb_dns_name" {
  value = aws_lb.main_application_lb.dns_name
}

output "ec2_subscription_app_arn" {
  value = aws_instance.first_zone_1.arn
}

output "ec2_stream_app_arn" {
  value = aws_instance.second_zone_1.arn
}