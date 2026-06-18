resource "azurerm_resource_group" "rg" {
  location = var.GEN["location"]
  name     = var.GEN["name"]
}

# Create virtual network
resource "azurerm_virtual_network" "vn" {
  name                = var.NW["vpc_name"]
  address_space       = [var.NW["vpc_cidr"]]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "private" {
  name                 = var.NW["sn_private_name"]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = [var.NW["sn_private_cidr"]]
}

resource "azurerm_subnet" "public" {
  name                 = var.NW["sn_public_name"]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = [var.NW["sn_public_cidr"]]
}

# Create public IPs
resource "azurerm_public_ip" "devops-infra" {
  name                = var.GEN["name"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

