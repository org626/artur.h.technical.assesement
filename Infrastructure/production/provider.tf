provider "azurerm" {
  subscription_id = "09079f78-9f6f-4361-a6cc-bf28835ae172"
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-system"
    storage_account_name = "arturazuretfstate"
    container_name       = "terraform"
    key                  = "awaresome-prod.tfstate"
  }

}
