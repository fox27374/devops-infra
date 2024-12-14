
output "bastion-dns-name" {
  value = aws_eip.bastion.public_dns
}

resource "local_file" "ansible_inventory" {
  depends_on = [
    aws_instance.lab,
    aws_eip.bastion
  ]
  content = templatefile("${path.module}/templates/inventory.tftpl",
    {
      bastion_dns   = aws_route53_record.bastion
      guacamole_dns = aws_route53_record.guacamole
      lab_instances = aws_instance.lab.*
    }
  )
  filename = "../ansible/inventory.yml"
}

resource "local_file" "ip_list" {
  content = templatefile("${path.module}/templates/ip_list.tftpl",
    {
      bastion_instance = aws_instance.bastion
      lab_instances    = aws_instance.lab.*
    }
  )
  filename = "../ansible/ip_list.csv"
}
