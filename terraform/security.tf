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

# INGRESS RULES
# External to ALB HTTPS
resource "aws_vpc_security_group_ingress_rule" "external-2-alb-https" {
  security_group_id = aws_security_group.alb.id

  description = "external-2-alb-https"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "tcp"
  to_port     = 443
  from_port   = 443
  tags = {
    Name = "https"
  }
}

# ALB to public subnet HTTP
resource "aws_vpc_security_group_ingress_rule" "alb-2-public-http-in" {
  security_group_id = aws_security_group.public.id

  description                  = "alb-2-public-http-in"
  ip_protocol                  = "tcp"
  to_port                      = 8080
  from_port                    = 8080
  referenced_security_group_id = aws_security_group.alb.id
  tags = {
    Name = "http"
  }
}

# External to public subnet SSH
resource "aws_vpc_security_group_ingress_rule" "external-2-public-ssh" {
  security_group_id = aws_security_group.public.id

  description = "external-2-public-ssh"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 22
  tags = {
    Name = "ssh"
  }
}

# Public to private subnet SSH
resource "aws_vpc_security_group_ingress_rule" "public-2-private-ssh" {
  security_group_id = aws_security_group.private.id

  description = "public-2-private-ssh"
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 22
  cidr_ipv4   = var.NW["sn_public_cidr"]
  tags = {
    Name = "ssh"
  }
}

# Public to private subnet HTTP
resource "aws_vpc_security_group_ingress_rule" "public-2-private-http" {
  security_group_id = aws_security_group.private.id

  description = "public-2-private-http"
  ip_protocol = "tcp"
  to_port     = 80
  from_port   = 80
  cidr_ipv4   = var.NW["sn_public_cidr"]
  tags = {
    Name = "http"
  }
}

# Private to private subnet SSH
resource "aws_vpc_security_group_ingress_rule" "private-2-private-ssh" {
  security_group_id = aws_security_group.private.id

  description = "private-2-private-ssh"
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 22
  cidr_ipv4   = var.NW["sn_private_cidr"]
  tags = {
    Name = "ssh"
  }
}

# Public to private subnet ICMP
resource "aws_vpc_security_group_ingress_rule" "public-2-private-icmp" {
  security_group_id = aws_security_group.private.id

  description = "public-2-private-icmp"
  ip_protocol = "icmp"
  from_port   = 8
  to_port     = 0
  cidr_ipv4   = var.NW["sn_private_cidr"]
  tags = {
    Name = "icmp"
  }
}

# resource "aws_vpc_security_group_ingress_rule" "external-2-public-https" {
#   security_group_id = aws_security_group.public.id

#   description = "external-2-public-https"
#   cidr_ipv4   = var.NW["external_v4_cidr"]
#   ip_protocol = "tcp"
#   to_port     = 443
#   from_port   = 0
#   tags = {
#     Name = "https"
#   }
# }

# EGRESS RULES
# ALB to public HTTP
resource "aws_vpc_security_group_egress_rule" "alb-2-public-http-out" {
  security_group_id = aws_security_group.alb.id

  description = "alb-2-public-http-out"
  ip_protocol = "tcp"
  cidr_ipv4   = var.NW["sn_public_cidr"]
  to_port     = 8080
  from_port   = 8080
  tags = {
    Name = "http"
  }
}

# # ALB to private HTTP
# resource "aws_vpc_security_group_egress_rule" "alb-2-private-http" {
#   security_group_id = aws_security_group.alb.id

#   description = "alb-2-private-http"
#   ip_protocol                  = "tcp"
#   cidr_ipv4   = var.NW["sn_private_cidr"]
#   to_port                      = 80
#   from_port                    = 80
#   tags = {
#     Name = "http"
#   }
# }


# Public to external ALL
resource "aws_vpc_security_group_egress_rule" "public-2-external-all" {
  security_group_id = aws_security_group.public.id

  description = "public-2-external-all"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "-1"
  tags = {
    Name = "internet"
  }
}

# Private to external ALL
resource "aws_vpc_security_group_egress_rule" "private-2-external-all" {
  security_group_id = aws_security_group.private.id

  description = "private-2-external-all"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "-1"
  tags = {
    Name = "internet"
  }
}