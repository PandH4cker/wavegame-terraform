# First application load balancer
resource "aws_elb" "first" {
  name               = "first-application-elb"
  subnets            = [var.public_subnet_id]
  security_groups    = [var.main_security_group_id]
  cross_zone_load_balancing   = false

  instances                   = [aws_instance.first_zone_1.id]
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags = {
    Name = "First Elastic Load Balancer"
  }
}

# Second application load balancer
resource "aws_elb" "second" {
  name               = "second-application-elb"
  subnets            = [var.public_subnet_id]
  security_groups    = [var.main_security_group_id]
  cross_zone_load_balancing   = false

  instances                   = [aws_instance.second_zone_1.id]
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags = {
    Name = "Second Elastic Load Balancer"
  }
}