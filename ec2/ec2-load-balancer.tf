# First application load balancer
resource "aws_lb" "main_application_lb" {
  name               = "main-application-lb"
  load_balancer_type = "application"
  subnets            = [
    var.public_subnet_ids[0],
    var.public_subnet_ids[1]
  ]
  security_groups    = [
    var.vpc_security_group_ids[0], # HTTP
    var.vpc_security_group_ids[1], # HTTPS
    var.vpc_security_group_ids[4]  # SSH
  ]
  
  enable_cross_zone_load_balancing   = true

  idle_timeout                = 400

  access_logs {
    bucket = var.log_bucket_name
    //prefix = "lb-logs"
    enabled = true
  }

  tags = {
    Name = "Main Load Balancer"
  }
}

# Target Groups
resource "aws_lb_target_group" "sub_target_group" {
  name = "sub-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.main_vpc_id

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    protocol = "HTTP"
    port = 80
    path = "/"
    interval = 30
  }
}

resource "aws_lb_target_group" "stream_target_group" {
  name = "stream-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.main_vpc_id

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    protocol = "HTTP"
    port = 80
    path = "/"
    interval = 30
  }
}

# Attachments
resource "aws_lb_target_group_attachment" "subscription_tgatt" {
  target_group_arn = aws_lb_target_group.sub_target_group.arn
  target_id = aws_instance.first_zone_1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "stream_tgatt" {
  target_group_arn = aws_lb_target_group.stream_target_group.arn
  target_id = aws_instance.second_zone_1.id
  port = 80
}

resource "aws_lb_listener" "main_listener_lb" {
  load_balancer_arn = aws_lb.main_application_lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.sub_target_group.arn
    type = "forward"
  }
}

resource "aws_lb_listener_rule" "sub_listener_rule" {
  listener_arn = aws_lb_listener.main_listener_lb.arn

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.sub_target_group.arn
  }

  condition {
    query_string {
      key = "page"
      value = "subscription"
    }
  }
}

resource "aws_lb_listener_rule" "stream_listener_rule" {
  listener_arn = aws_lb_listener.main_listener_lb.arn

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.stream_target_group.arn
  }

  condition {
    query_string {
      key = "page"
      value = "stream"
    }
  }
}

/*# Second application load balancer
resource "aws_elb" "second" {
  name               = "second-application-elb"
  subnets            = [var.public_subnet_ids[1]]
  security_groups    = [
    var.vpc_security_group_ids[0], # HTTP
    var.vpc_security_group_ids[1], # HTTPS
    var.vpc_security_group_ids[4]  # SSH
  ]
  cross_zone_load_balancing   = true

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
}*/