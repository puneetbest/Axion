resource "azurerm_resource_group" "data" {
  name     = "rg-axion-data-${var.environment}"
  location = var.location
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  name = "axiondatabase-${var.environment}"

  resource_group_name = azurerm_resource_group.data.name
  location            = azurerm_resource_group.data.location

  version = "16"

  administrator_login    = var.postgres_admin_username
  administrator_password = var.postgres_admin_password

  sku_name = "GP_Standard_D2s_v3"

  storage_mb = 32768

  backup_retention_days = 14

  geo_redundant_backup_enabled = false

  public_network_access_enabled = false

  zone = "1"

  tags = var.tags
}
resource "azurerm_private_endpoint" "postgres" {
  name = "pep-postgres-${var.environment}"

  location            = azurerm_resource_group.data.location
  resource_group_name = azurerm_resource_group.data.name

  subnet_id = var.private_endpoint_subnet_id

  private_service_connection {
    name = "psc-postgres-${var.environment}"

    private_connection_resource_id = azurerm_postgresql_flexible_server.postgres.id

    subresource_names = [
      "postgresqlServer"
    ]

    is_manual_connection = false
  }

  private_dns_zone_group {
    name = "postgres-private-dns-zone-group"

    private_dns_zone_ids = [
      azurerm_private_dns_zone.postgres.id
    ]
  }
}
resource "azurerm_private_dns_zone" "postgres" {
  name = "privatelink.postgres.database.azure.com"

  resource_group_name = azurerm_resource_group.data.name

  tags = var.tags
}
resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name = "link-postgres-to-axion-vnet"

  resource_group_name = azurerm_resource_group.data.name

  private_dns_zone_name = azurerm_private_dns_zone.postgres.name

  virtual_network_id = var.vnet_id

  registration_enabled = false
}
resource "azurerm_postgresql_flexible_server_database" "axion" {
  name = "axion-db"

  server_id = azurerm_postgresql_flexible_server.postgres.id

  charset   = "UTF8"
  collation = "en_US.utf8"
}