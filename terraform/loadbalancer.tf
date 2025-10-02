resource "aws_lb" "devops-infra" {
  name               = "devops-infra"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public.id, aws_subnet.private.id]

  enable_deletion_protection = false
  preserve_host_header = true

  tags = {
    Environment = "devops"
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

  depends_on = [aws_acm_certificate_validation.lab_validation]
}

resource "aws_lb_target_group" "guacamole" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    port                = 80
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

resource "aws_lb_target_group_attachment" "guacamole" {
  target_group_arn = aws_lb_target_group.guacamole.arn
  target_id        = aws_instance.bastion.id
  port             = 80
}

resource "aws_lb_target_group" "splunk" {
  health_check {
    interval            = 10
    path                = "/en-US/account/login"
    protocol            = "HTTP"
    port                = 80
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "splunk"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.devops-infra.id
}

resource "aws_lb_target_group_attachment" "splunk" {
  target_group_arn = aws_lb_target_group.splunk.arn
  target_id        = aws_instance.splunk.id
  port             = 80
}

resource "aws_lb_target_group" "lab_tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    port                = 8080
  }
  count = var.EC2["lab_count"]
  name = "lab${format(
    "%03d",
    element(split(".", aws_instance.lab[count.index].private_ip), 3)
  )}"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.devops-infra.id
  target_type = "instance"

  stickiness {
    enabled         = true
    type            = "lb_cookie"
    cookie_duration = 86400
  }
}

resource "aws_lb_target_group_attachment" "lab_attachment" {
  count            = var.EC2["lab_count"]
  target_group_arn = aws_lb_target_group.lab_tg[count.index].arn
  target_id        = aws_instance.lab[count.index].id
  port             = 8080

  depends_on = [aws_lb_target_group.lab_tg]
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

resource "aws_lb_listener_rule" "splunk_rule" {
  listener_arn = aws_lb_listener.devops-infra.arn

  condition {
    host_header {
      values = [var.NW["splunk_dns_fqdn"]]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.splunk.arn
  }

  tags = {
    Name = "splunk"
  }
}

resource "aws_lb_listener_rule" "lab_listener_rule" {
  count        = var.EC2["lab_count"]
  listener_arn = aws_lb_listener.devops-infra.arn
  priority     = count.index + 2 # Ensure unique priority for each rule

  condition {
    host_header {
      values = ["lab${format("%03d", element(split(".", aws_instance.lab[count.index].private_ip), 3))}.${var.NW["domain_name"]}"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab_tg[count.index].arn
  }

  tags = {
    Name = "lab${format("%03d", element(split(".", aws_instance.lab[count.index].private_ip), 3))}"
  }
}