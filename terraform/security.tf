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

resource "aws_vpc_security_group_ingress_rule" "ssh_from_external" {
  security_group_id = aws_security_group.public.id

  description = "SSH from external"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 0
  tags = {
    Name = "ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "https_from_external" {
  security_group_id = aws_security_group.public.id

  description = "HTTPS from external"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "tcp"
  to_port     = 443
  from_port   = 0
  tags = {
    Name = "https"
  }
}

resource "aws_vpc_security_group_egress_rule" "public_to_external" {
  security_group_id = aws_security_group.public.id

  description = "All to external"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "-1"
  tags = {
    Name = "internet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_public" {
  security_group_id = aws_security_group.private.id

  description = "SSH from public"
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 0
  cidr_ipv4   = var.NW["sn_public_cidr"]
  tags = {
    Name = "ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_private" {
  security_group_id = aws_security_group.private.id

  description = "SSH from private"
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 0
  cidr_ipv4   = var.NW["sn_private_cidr"]
  tags = {
    Name = "ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_from_public" {
  security_group_id = aws_security_group.private.id

  description = "HTTP from public"
  ip_protocol = "tcp"
  to_port     = 80
  from_port   = 0
  cidr_ipv4   = var.NW["sn_public_cidr"]
  tags = {
    Name = "http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "icmp_from_private" {
  security_group_id = aws_security_group.private.id

  description = "ICMP from private"
  ip_protocol = "icmp"
  from_port   = 8
  to_port     = 0
  cidr_ipv4   = var.NW["sn_private_cidr"]
  tags = {
    Name = "icmp"
  }
}

resource "aws_vpc_security_group_egress_rule" "private_to_external" {
  security_group_id = aws_security_group.private.id

  description = "Private to external"
  cidr_ipv4   = var.NW["external_v4_cidr"]
  ip_protocol = "-1"
  tags = {
    Name = "internet"
  }
}