resource "azurerm_resource_group" "rg" {
  for_each = var.resource
  name     = each.key
  location = each.value
}

resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.azkuberser
  name                = each.key
  location            = azurerm_resource_group.rg[each.value.rg_name].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_name].name
  dns_prefix          = each.value.dns

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DC2ads_v5"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

