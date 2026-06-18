# Create bastion instance
resource "aws_instance" "bastion" {
  ami                    = var.EC2["bastion_ami"]
  instance_type          = var.EC2["bastion_instance_type"]
  subnet_id              = aws_subnet.public.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.bastion.id, aws_security_group.public.id]
  tags = {
    Name = var.EC2["bastion_name"],
    Type = "bastion"
  }
}

# Create Splunk instance
resource "aws_instance" "splunk" {
  ami                    = var.EC2["splunk_ami"]
  instance_type          = var.EC2["splunk_instance_type"]
  subnet_id              = aws_subnet.private.id
  user_data              = file("cloud-config/user_data.cloud")
  vpc_security_group_ids = [aws_security_group.splunk.id]
  root_block_device {
    volume_size = var.EC2["splunk_volume_size"]
  }
  tags = {
    Name = var.EC2["splunk_name"],
    Type = "splunk"
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
    ID   = "${format("%02d", count.index + 1)}"
    Type = "lab"
  }
}

# Set instance name based on IP
resource "aws_ec2_tag" "lab_name_tag" {
  for_each = { for i, inst in aws_instance.lab : i => inst }

  resource_id = each.value.id
  key         = "Name"
  value       = "lab${format("%03d", element(split(".", each.value.private_ip), 3))}"

  depends_on = [aws_instance.lab]
}


locals {
  lab_instance_names = [
    for instance in aws_instance.lab[*] :
    "lab${format("%03d", element(split(".", instance.private_ip), 3))}"
  ]

  lab_dns_names = [
    for name in local.lab_instance_names :
    "${name}.${var.NW["domain_name"]}"
  ]

  # Additional static or custom DNS names
  additional_dns_names = [
    "guacamole.${var.NW.domain_name}",
    "bastion.${var.NW.domain_name}"
  ]

  cert_dns_names = concat(local.lab_dns_names, local.additional_dns_names)

  depends_on = [aws_instance.lab]
}

