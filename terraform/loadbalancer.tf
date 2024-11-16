resource "aws_lb" "bastion" {
  name               = "bastion"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public.id]
  subnets            = [aws_subnet.public.id, aws_subnet.private.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
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

resource "aws_lb_listener" "bastion" {
  load_balancer_arn = aws_lb.bastion.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.guacamole.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "HEALTHY"
      status_code  = "200"
    }
  }
}

# resource "aws_lb_listener_rule" "bastion" {
#   listener_arn = aws_lb_listener.bastion.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.bastion.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/guacamole/*"]
#     }
#   }
# }

# Fetch all running EC2 instances
data "aws_instances" "lab_instances" {
  filter {
    name   = "tag:type"
    values = ["docker"]
  }

  filter {
    name   = "tag:type"
    values = ["k8s"]
  }
}

# Fetch detailed information about each instance
data "aws_instance" "details" {
  for_each    = toset(data.aws_instances.lab_instances.ids)
  instance_id = each.key
}

# Create a Target Group for each EC2 instance
resource "aws_lb_target_group" "target_group" {
  for_each = data.aws_instance.details

  # Use the instance 'Name' tag or fallback to instance ID if the Name tag is missing
  name     = lookup(each.value.tags, "Name", each.key)
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.devops-infra.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-299"
  }
}


# Attach each EC2 instance to its corresponding Target Group
resource "aws_lb_target_group_attachment" "attachment" {
  for_each = data.aws_instance.details

  target_group_arn = aws_lb_target_group.target_group[each.key].arn
  target_id        = each.value.id
  port             = 80
}