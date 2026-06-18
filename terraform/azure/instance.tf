data "azurerm_dns_zone" "azure_ntslab_eu" {
  name                = var.NW["domain_name"]
  resource_group_name = "rg-infra-di-ibk"
}

resource "azurerm_network_interface" "bastion_nic" {
  name                = "bastion_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "bastion_public"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops-infra.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "bastion" {
  network_interface_id      = azurerm_network_interface.bastion_nic.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

# Create virtual machine
resource "azurerm_virtual_machine" "bastion" {
  name                             = var.EC2["bastion_name"]
  location                         = azurerm_resource_group.rg.location
  resource_group_name              = azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.bastion_nic.id]
  vm_size                          = "Standard_B2s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = var.EC2["bastion_name"]
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = var.EC2["lab_volume_size"]
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.EC2["bastion_name"]
    admin_username = "labadmin"
    custom_data    = filebase64("cloud-config/user_data.cloud")
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/labadmin/.ssh/authorized_keys"
      key_data = file("files/dummy_azure_lab.pub")
    }
  }
}

resource "azurerm_dns_a_record" "bastion" {
  name                = "bastion"
  zone_name           = data.azurerm_dns_zone.azure_ntslab_eu.name
  resource_group_name = data.azurerm_dns_zone.azure_ntslab_eu.resource_group_name
  ttl                 = 300

  records = [azurerm_public_ip.devops-infra.ip_address]
}


# Create Splunk VM
resource "azurerm_network_interface" "splunk_nic" {
  name                = "splunk_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "splunk_private"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.my_terraform_private_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "splunk" {
  network_interface_id      = azurerm_network_interface.splunk_nic.id
  network_security_group_id = azurerm_network_security_group.splunk.id
}

# Create virtual machine
resource "azurerm_virtual_machine" "splunk" {
  name                             = var.EC2["splunk_name"]
  location                         = azurerm_resource_group.rg.location
  resource_group_name              = azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.splunk_nic.id]
  vm_size                          = "Standard_B2s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = var.EC2["splunk_name"]
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = var.EC2["splunk_volume_size"]
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.EC2["splunk_name"]
    admin_username = "labadmin"
    custom_data    = filebase64("cloud-config/user_data.cloud")
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/labadmin/.ssh/authorized_keys"
      key_data = file("files/dummy_azure_lab.pub")
    }
  }
}

resource "azurerm_dns_a_record" "splunk" {
  name                = "splunk"
  zone_name           = data.azurerm_dns_zone.azure_ntslab_eu.name
  resource_group_name = data.azurerm_dns_zone.azure_ntslab_eu.resource_group_name
  ttl                 = 300

  records = [azurerm_public_ip.devops-infra.ip_address]
}



resource "azurerm_network_interface" "lab" {
  count               = var.EC2["lab_count"]
  name                = "lab${format("%03d", count.index + 1)}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "lab_private"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
  }
}

locals {
  nic_map = {
    for i, nic in azurerm_network_interface.lab :
    i => {
      id         = nic.id
      private_ip = nic.private_ip_address
      last_octet = tonumber(element(split(".", nic.private_ip_address), 3))
    }
  }
}

resource "azurerm_virtual_machine" "lab" {
  count                            = var.EC2["lab_count"]
  name                             = "lab${format("%03d", local.nic_map[count.index].last_octet)}"
  location                         = azurerm_resource_group.rg.location
  resource_group_name              = azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.lab[count.index].id]
  vm_size                          = "Standard_B2s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "lab${format("%03d", local.nic_map[count.index].last_octet)}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = var.EC2["lab_volume_size"]
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_profile {
    computer_name  = "lab${format("%03d", local.nic_map[count.index].last_octet)}"
    admin_username = "labadmin"
    custom_data    = filebase64("cloud-config/user_data.cloud")
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/labadmin/.ssh/authorized_keys"
      key_data = file("files/dummy_azure_lab.pub")
    }
  }
}

resource "azurerm_dns_a_record" "lab" {
  count                            = var.EC2["lab_count"]
  name                             = "lab${format("%03d", local.nic_map[count.index].last_octet)}"
  zone_name           = data.azurerm_dns_zone.azure_ntslab_eu.name
  resource_group_name = data.azurerm_dns_zone.azure_ntslab_eu.resource_group_name
  ttl                 = 300

  records = [azurerm_public_ip.devops-infra.ip_address]
}
