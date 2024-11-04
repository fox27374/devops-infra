
output "bastion-dns-name" {
  value = aws_eip.bastion.public_dns
}

resource "local_file" "ansible_inventory" {
  depends_on = [
    aws_instance.docker,
    aws_instance.k8s,
    aws_eip.bastion
  ]
  content = templatefile("${path.module}/templates/inventory.tftpl",
    {
      bastion_instance  = aws_instance.bastion
      docker_instances = aws_instance.docker.*
      k8s_instances     = aws_instance.k8s.*
    }
  )
  filename = "../ansible/inventory.yml"
}

resource "local_file" "ip_list" {
  content = templatefile("${path.module}/templates/ip_list.tftpl",
    {
      bastion_instance  = aws_instance.bastion
      docker_instances = aws_instance.docker.*
      k8s_instances = aws_instance.k8s.*
    }
  )
  filename = "../ansible/ip_list.csv"
}
