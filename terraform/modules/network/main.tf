resource "azurerm_resource_group" "network" {
  name     = "rg-axion-network-${var.environment}"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-axion-${var.environment}"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name

  address_space = [
    "10.224.0.0/16"
  ]

  tags = var.tags
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks-${var.environment}"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes = [
    "10.224.0.0/22"
  ]
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = "snet-private-endpoints-${var.environment}"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes = [
    "10.224.10.0/24"
  ]

  private_endpoint_network_policies = "Disabled"
}