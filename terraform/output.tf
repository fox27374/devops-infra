
output "bastion-dns-name" {
  value = aws_eip.bastion.public_dns
}

resource "local_file" "ansible_inventory" {
  depends_on = [
    aws_instance.private,
    aws_instance.lab,
    aws_eip.bastion
  ]
  content = templatefile("${path.module}/templates/inventory.tftpl",
    {
      bastion_instance  = aws_instance.bastion
      private_instances = aws_instance.private.*
      lab_instances     = aws_instance.lab.*
    }
  )
  filename = "../ansible/inventory.yml"
}

resource "local_file" "ssh_config" {
  content = templatefile("${path.module}/templates/ssh_config.tftpl",
    {
      bastion_instance  = aws_instance.bastion
      private_instances = aws_instance.private.*
    }
  )
  filename = "output/ssh_config"
}

resource "local_file" "nginx_config" {
  content = templatefile("${path.module}/templates/nginx_config.tftpl",
    {
      lab_instances = aws_instance.lab.*
    }
  )
  filename = "../ansible/bastion/files/linux-training.conf"
}
