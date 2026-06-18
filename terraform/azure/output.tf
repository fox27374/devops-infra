resource "local_file" "ansible_inventory" {
  depends_on = [
    azurerm_virtual_machine.lab,
    azurerm_public_ip.devops-infra
  ]
  content = templatefile("${path.module}/templates/inventory.tftpl",
    {
      domain_name           = var.NW["domain_name"]
      bastion_dns           = azurerm_dns_a_record.bastion
      bastion_instance_name = azurerm_virtual_machine.bastion.name
      splunk_instance       = azurerm_dns_a_record.splunk
      splunk_instance_name  = azurerm_virtual_machine.splunk.name
      splunk_nic            = azurerm_network_interface.splunk_nic
      lab_instances         = azurerm_virtual_machine.lab.*
      lab_nics              = azurerm_network_interface.lab.*
    }
  )
  filename = "../../ansible/inventory.yml"
}

# resource "local_file" "ip_list" {
#   content = templatefile("${path.module}/templates/ip_list.tftpl",
#     {
#       bastion_instance = azurerm_virtual_machine.bastion
#       lab_instances    = azurerm_virtual_machine.lab.*
#     }
#   )
#   filename = "../ansible/ip_list.csv"
# }