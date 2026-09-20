terraform {
  required_version = ">= 1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.77.0"
    }
  }
    backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "axiontfstateprod"
    container_name       = "tfstate"
    key                  = "axion-prod.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}

  subscription_id = "731d5e6f-b42d-4ca7-925a-186183e64421"
}