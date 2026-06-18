# Create VPC
resource "aws_vpc" "devops-infra" {
  cidr_block           = var.NW["vpc_cidr"]
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.NW["vpc_name"]
  }
}

# Create Subnets
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.devops-infra.id
  cidr_block        = var.NW["sn_private_cidr"]
  availability_zone = var.NW["az2"]
  tags = {
    Name = var.NW["sn_private_name"]
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.devops-infra.id
  cidr_block        = var.NW["sn_public_cidr"]
  availability_zone = var.NW["az1"]
  tags = {
    Name = var.NW["sn_public_name"]
  }
}

# Create internet gateway
resource "aws_internet_gateway" "devops-infra" {
  vpc_id = aws_vpc.devops-infra.id
  tags = {
    Name = var.NW["vpc_name"]
  }
}

# Create NAT gateway
resource "aws_nat_gateway" "devops-infra" {
  allocation_id = aws_eip.nat-gateway.id
  subnet_id     = aws_subnet.public.id
  depends_on    = [aws_internet_gateway.devops-infra]
  tags = {
    Name = var.NW["vpc_name"]
  }
}

# Routing table for public subnet
resource "aws_route_table" "devops-infra-public" {
  vpc_id = aws_vpc.devops-infra.id
  route {
    cidr_block = var.NW["external_v4_cidr"]
    gateway_id = aws_internet_gateway.devops-infra.id
  }
  tags = {
    Name = var.NW["sn_public_name"]
  }
}

# Routing table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.devops-infra.id
  route {
    cidr_block     = var.NW["external_v4_cidr"]
    nat_gateway_id = aws_nat_gateway.devops-infra.id
    #gateway_id = aws_internet_gateway.devops-infra.id
  }
  tags = {
    Name = var.NW["sn_private_name"]
  }
}

# Associate routing tables with subnets
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.devops-infra-public.id
}

# Create elastic IPs
resource "aws_eip" "nat-gateway" {
  depends_on = [aws_internet_gateway.devops-infra]
  tags = {
    Name = var.NW["vpc_name"]
  }
}

resource "aws_eip" "bastion" {
  depends_on = [aws_instance.bastion]
  instance   = aws_instance.bastion.id
  tags = {
    Name = var.NW["vpc_name"]
  }
}


