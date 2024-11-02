resource "aws_security_group" "public" {
  name        = "Public"
  description = "Public"
  vpc_id      = aws_vpc.devops-infra.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"] 
    cidr_blocks      = ["89.105.180.0/24"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"]
    cidr_blocks      = ["89.105.180.0/24"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"]
    cidr_blocks      = ["89.105.180.0/24"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_security_group" "private" {
  name        = "Private"
  description = "Private"
  vpc_id      = aws_vpc.devops-infra.id

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  ingress {
    description     = "HTTP from Bastion"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  ingress {
    description = "ICMP from private"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.NW["sn_private_cidr"]]
  }

  ingress {
    description = "SSH from private"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.NW["sn_private_cidr"]]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Private"
  }
}
