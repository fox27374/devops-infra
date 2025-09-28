resource "aws_security_group" "public" {
  name        = "Public"
  description = "Public"
  vpc_id      = aws_vpc.devops-infra.id
  tags = {
    Name = "Public"
  }
}

resource "aws_security_group" "private" {
  name        = "Private"
  description = "Private"
  vpc_id      = aws_vpc.devops-infra.id
  tags = {
    Name = "Private"
  }
}

resource "aws_security_group" "alb" {
  name        = "ALB"
  description = "ALB"
  vpc_id      = aws_vpc.devops-infra.id
  tags = {
    Name = "ALB"
  }
}

resource "aws_security_group" "bastion" {
  name        = "Bastion"
  description = "Bastion"
  vpc_id      = aws_vpc.devops-infra.id
  tags = {
    Name = "Bastion"
  }
}

#############
# ALB RULES #
#############
# External to ALB HTTPS IN
resource "aws_vpc_security_group_ingress_rule" "external-https-in" {
  security_group_id = aws_security_group.alb.id

  description = "External HTTPS IN"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "tcp"
  to_port     = 443
  from_port   = 443
  tags = {
    Name = "External HTTPS IN"
  }
}

# ALB to public HTTP OUT
resource "aws_vpc_security_group_egress_rule" "public-http-out" {
  security_group_id = aws_security_group.alb.id

  description = "Public HTTP OUT"
  ip_protocol = "tcp"
  cidr_ipv4   = var.NW["sn_public_cidr"]
  to_port     = 80
  from_port   = 80
  tags = {
    Name = "Public HTTP OUT"
  }
}

# ALB to private HTTP OUT
resource "aws_vpc_security_group_egress_rule" "alb-2-private-http" {
  security_group_id = aws_security_group.alb.id

  description = "alb-2-private-http"
  ip_protocol                  = "tcp"
  cidr_ipv4   = var.NW["sn_private_cidr"]
  to_port                      = 80
  from_port                    = 80
  tags = {
    Name = "alb-2-private-http"
  }
}

################
# PUBLIC RULES #
################

# ALB to public subnet HTTP IN
resource "aws_vpc_security_group_ingress_rule" "alb-http-in" {
  security_group_id = aws_security_group.public.id

  description                  = "ALB HTTP IN"
  ip_protocol                  = "tcp"
  to_port                      = 80
  from_port                    = 80
  referenced_security_group_id = aws_security_group.alb.id
  tags = {
    Name = "ALB HTTP IN"
  }
}

# External to public subnet SSH IN
resource "aws_vpc_security_group_ingress_rule" "external-ssh-in" {
  security_group_id = aws_security_group.public.id

  description = "External SSH IN"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 22
  tags = {
    Name = "External SSH IN"
  }
}

# Public to external ALL OUT
resource "aws_vpc_security_group_egress_rule" "external-public-all-out" {
  security_group_id = aws_security_group.public.id

  description = "External ALL OUT"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "-1"
  tags = {
    Name = "External ALL OUT"
  }
}

#################
# PRIVATE RULES #
#################

# Bastion to private subnet SSH IN
resource "aws_vpc_security_group_ingress_rule" "bastion-ssh-in" {
  security_group_id = aws_security_group.private.id

  description = "Bastion SSH IN"
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 22
  referenced_security_group_id = aws_security_group.bastion.id
  tags = {
    Name = "Bastion SSH IN"
  }
}

# Bastion to private subnet HTTP IN
resource "aws_vpc_security_group_ingress_rule" "bastion-http-in" {
  security_group_id = aws_security_group.private.id

  description = "Bastion HTTP IN"
  ip_protocol = "tcp"
  to_port     = 80
  from_port   = 80
  referenced_security_group_id = aws_security_group.bastion.id
  tags = {
    Name = "Bastion HTTP IN"
  }
}

# Private to private subnet SSH IN
resource "aws_vpc_security_group_ingress_rule" "private-ssh-in" {
  security_group_id = aws_security_group.private.id

  description = "Private SSH IN"
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 22
  cidr_ipv4   = var.NW["sn_private_cidr"]
  tags = {
    Name = "Private SSH IN"
  }
}

# Public to private subnet ICMP IN
resource "aws_vpc_security_group_ingress_rule" "public-icmp-in" {
  security_group_id = aws_security_group.private.id

  description = "Public ICMP IN"
  ip_protocol = "icmp"
  from_port   = 8
  to_port     = 0
  cidr_ipv4   = var.NW["sn_public_cidr"]
  tags = {
    Name = "Public ICMP IN"
  }
}

# Private to external ALL OUT
resource "aws_vpc_security_group_egress_rule" "external-private-all-out" {
  security_group_id = aws_security_group.private.id

  description = "External ALL OUT"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "-1"
  tags = {
    Name = "External ALL OUT"
  }
}
