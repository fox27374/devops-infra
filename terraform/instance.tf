# Create bastion instance
resource "aws_instance" "bastion" {
  ami                    = var.EC2["bastion_ami"]
  instance_type          = var.EC2["bastion_instance_type"]
  subnet_id              = aws_subnet.public.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.public.id]
  tags = {
    Name    = var.EC2["bastion_name"],
    Type    = "bastion",
    SubType = "bastion"
  }
}

# Create docker lab instances
resource "aws_instance" "docker" {
  count                  = var.EC2["docker_count"]
  ami                    = var.EC2["docker_ami"]
  instance_type          = var.EC2["docker_instance_type"]
  subnet_id              = aws_subnet.private.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.private.id]
  root_block_device {
    volume_size = "20"
  }
  tags = {
    Name    = "${var.EC2["docker_name"]}${format("%02d", count.index + 1)}",
    Type    = "lab",
    SubType = "docker"
  }
}

# Create k8s lab instances
resource "aws_instance" "k8s" {
  count                  = var.EC2["k8s_count"]
  ami                    = var.EC2["k8s_ami"]
  instance_type          = var.EC2["k8s_instance_type"]
  subnet_id              = aws_subnet.private.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.private.id]
  tags = {
    Name    = "${var.EC2["k8s_name"]}${format("%02d", count.index + 1)}",
    Type    = "lab",
    SubType = "k8s"
  }
}

