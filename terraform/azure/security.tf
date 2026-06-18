# Network Security Groups
resource "azurerm_network_security_group" "public" {
  name                = "public"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "private" {
  name                = "private"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "splunk" {
  name                = "splunk"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

#########################
# Bastion Security Rules
#########################

resource "azurerm_network_security_rule" "external-bastion-ssh-in" {
  name                        = "external-bastion-ssh-in"
  description                 = "External SSH IN"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22-22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.bastion.name
}

resource "azurerm_network_security_rule" "external-bastion-http-in" {
  name                        = "external-bastion-http-in"
  description                 = "External HTTP IN"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80-80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.bastion.name
}

resource "azurerm_network_security_rule" "external-bastion-https-in" {
  name                        = "external-bastion-https-in"
  description                 = "External HTTPS IN"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443-443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.bastion.name
}


########################
# Splunk Security Rules
########################

resource "azurerm_network_security_rule" "public-splunk-ssh-in" {
  name                        = "public-splunk-ssh-in"
  description                 = "Public SSH IN"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22-22"
  source_address_prefix       = var.NW["sn_public_cidr"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.splunk.name
}

resource "azurerm_network_security_rule" "private-splunk-ssh-in" {
  name                        = "private-splunk-ssh-in"
  description                 = "Private SSH IN"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22-22"
  source_address_prefix       = var.NW["sn_private_cidr"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.splunk.name
}

resource "azurerm_network_security_rule" "public-splunk-hec-in" {
  name                        = "public-splunk-hec-in"
  description                 = "Public HEC IN"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8088-8088"
  source_address_prefix       = var.NW["sn_public_cidr"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.splunk.name
}

resource "azurerm_network_security_rule" "private-splunk-hec-in" {
  name                        = "private-splunk-hec-in"
  description                 = "Private HEC IN"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8088-8088"
  source_address_prefix       = var.NW["sn_private_cidr"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.splunk.name
}

resource "azurerm_network_security_rule" "public-splunk-http-in" {
  name                        = "public-splunk-http-in"
  description                 = "Public HTTP IN"
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80-80"
  source_address_prefix       = var.NW["sn_public_cidr"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.splunk.name
}

#########################
# Private Security Rules
#########################
resource "azurerm_network_security_rule" "private-private-ssh-in" {
  name                        = "private-private-ssh-in"
  description                 = "Private SSH IN"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22-22"
  source_address_prefix       = var.NW["sn_private_cidr"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.private.name
}
