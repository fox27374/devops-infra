# Create bastion instance
resource "aws_instance" "bastion" {
  ami                    = var.EC2["ami"]
  instance_type          = var.EC2["instance_type"]
  subnet_id              = aws_subnet.public.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.public.id]
  tags = {
    Name = var.EC2["bastion_name"],
    Type = "bastion"
  }
}

# Create private EC2 instances
resource "aws_instance" "private" {
  count                  = var.EC2["private_count"]
  ami                    = var.EC2["ami"]
  instance_type          = var.EC2["instance_type"]
  subnet_id              = aws_subnet.private.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.private.id]
  tags = {
    Name = "${var.EC2["student_name"]}${format("%02d", count.index + 1)}",
    Type = "student"
  }
}

# Create lab EC2 instances
resource "aws_instance" "lab" {
  count = var.EC2["lab_count"]
  ami   = var.EC2["ami"]
  #instance_type          = var.EC2["instance_type"]
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.private.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.private.id]
  tags = {
    Name = "${var.EC2["student_name"]}${format("%02d", count.index + 1)}",
    Type = "lab"
  }
}

