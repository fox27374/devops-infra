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
    target_group_arn = aws_lb_target_group.bastion.arn
  }
}


resource "aws_lb_target_group" "bastion" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "bastion"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.devops-infra.id
}

resource "aws_lb_target_group_attachment" "bastion" {
  target_group_arn = aws_lb_target_group.bastion.arn
  target_id        = aws_instance.bastion.id
  port             = 80
}

resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = aws_lb_listener.devops-infra.arn

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bastion.arn
  }

  tags = {
    Name = "bastion"
  }
}