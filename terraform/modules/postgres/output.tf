output "postgres_fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "postgres_server_name" {
  value = azurerm_postgresql_flexible_server.postgres.name
}

output "postgres_database_name" {
  value = azurerm_postgresql_flexible_server_database.axion.name
}

output "private_endpoint_ip" {
  value = azurerm_private_endpoint.postgres.private_service_connection
}