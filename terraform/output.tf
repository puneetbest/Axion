output "aks_name" {
  value = module.aks.aks_name
}

output "aks_resource_group" {
  value = module.aks.resource_group_name
}

output "acr_login_server" {
  value = module.aks.acr_login_server
}

output "postgres_fqdn" {
  value = module.postgres.postgres_fqdn
}

output "postgres_database" {
  value = module.postgres.postgres_database_name
}