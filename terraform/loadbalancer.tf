resource "aws_lb" "devops-infra" {
  name               = "devops-infra"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public.id]
  subnets            = [aws_subnet.public.id, aws_subnet.private.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "devops-infra" {
  load_balancer_arn = aws_lb.devops-infra.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.lab.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.guacamole.arn
  }
}

resource "aws_lb_target_group" "guacamole" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "guacamole"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.devops-infra.id
}

resource "aws_lb_target_group" "nginx" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "nginx"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.devops-infra.id
}

resource "aws_lb_target_group_attachment" "guacamole" {
  target_group_arn = aws_lb_target_group.guacamole.arn
  target_id        = aws_instance.bastion.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "nginx" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.bastion.id
  port             = 8080
}

resource "aws_lb_listener_rule" "guacamole_rule" {
  listener_arn = aws_lb_listener.devops-infra.arn

  condition {
    host_header {
      values = [var.NW["guacamole_dns_fqdn"]]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.guacamole.arn
  }

  tags = {
    Name = "bastion"
  }
}

resource "aws_lb_listener_rule" "nginx_rule" {
  listener_arn = aws_lb_listener.devops-infra.arn

  condition {
    host_header {
      values = [var.NW["lb_dns_fqdn"]]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = {
    Name = "nginx"
  }
}