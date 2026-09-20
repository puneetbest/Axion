locals {
  common_tags = {
    project     = "axion"
    environment = var.environment
    managed_by  = "terraform"
  }
}

module "network" {
  source = "./modules/network"

  location    = var.location
  environment = var.environment

  tags = local.common_tags
}

module "aks" {
  source = "./modules/aks"

  location    = var.location
  environment = var.environment

  aks_subnet_id = module.network.aks_subnet_id

  tags = local.common_tags
}

module "postgres" {
  source = "./modules/postgres"

  location    = var.location
  environment = var.environment

  vnet_id = module.network.vnet_id

  private_endpoint_subnet_id = module.network.private_endpoint_subnet_id

  postgres_admin_username = var.postgres_admin_username
  postgres_admin_password = var.postgres_admin_password

  tags = local.common_tags
}