terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.77.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "731d5e6f-b42d-4ca7-925a-186183e64421"
}