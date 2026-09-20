resource "azurerm_resource_group" "app" {
  name     = "rg-axion-app-${var.environment}"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "axionacr${var.environment}"
  resource_group_name = azurerm_resource_group.app.name
  location            = azurerm_resource_group.app.location

  sku           = "Standard"
  admin_enabled = false

  tags = var.tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-axion-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name

  dns_prefix = "axion-${var.environment}"

  kubernetes_version = null

  default_node_pool {
    name = "system"

    vm_size = "Standard_D2s_v5"

    vnet_subnet_id = var.aks_subnet_id

    auto_scaling_enabled = true

    min_count = 2
    max_count = 5

    node_count = 2

    type = "VirtualMachineScaleSets"

    zones = [
      "1",
      "2",
      "3"
    ]

    upgrade_settings {
      max_surge = "33%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"

    load_balancer_sku = "standard"

    service_cidr = "10.10.0.0/16"
    dns_service_ip = "10.10.0.10"
  }

  role_based_access_control_enabled = true

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  scope = azurerm_container_registry.acr.id

  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}