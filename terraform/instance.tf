# Create bastion instance
resource "aws_instance" "bastion" {
  ami                    = var.EC2["bastion_ami"]
  instance_type          = var.EC2["bastion_instance_type"]
  subnet_id              = aws_subnet.public.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.public.id]
  tags = {
    Name = var.EC2["bastion_name"],
    Type = "bastion"
  }
}

# Create ab instances
resource "aws_instance" "lab" {
  count                  = var.EC2["lab_count"]
  ami                    = var.EC2["lab_ami"]
  instance_type          = var.EC2["lab_instance_type"]
  subnet_id              = aws_subnet.private.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.private.id]
  root_block_device {
    volume_size = var.EC2["lab_volume_size"]
  }
  tags = {
    Name = "${var.EC2["lab_name"]}${format("%02d", count.index + 1)}",
    ID   = "${format("%02d", count.index + 1)}"
    Type = "lab"
  }
}


locals {
  lab_instance_names = [
    for instance in aws_instance.lab[*] : "${instance.tags["Name"]}"
  ]

  lab_dns_names = [
    for instance in aws_instance.lab[*] : "${instance.tags["Name"]}.${var.NW["domain_name"]}"
  ]

  # Additional static or custom DNS names
  additional_dns_names = [
    var.NW["guacamole_dns_fqdn"],
    var.NW["bastion_dns_fqdn"]
  ]

  cert_dns_names = concat(local.lab_dns_names, local.additional_dns_names)
}

