terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }

    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azurerm" {
  # Configure your Azure subscription ID
  # subscription_id = "your-subscription-id"
  features {}
}

provider "azapi" {
  # This provider inherits authentication from azurerm
}