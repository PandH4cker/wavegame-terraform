output "main_lb_dns_name" {
  value = aws_lb.main_application_lb.dns_name
}
/*output "second_elb_dns_name" {
  value = aws_elb.second.dns_name
}*/