terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "recipe-tfstate-rg"
    storage_account_name = "recipetfstated7f098"
    container_name       = "tfstate"
    key                  = "recipe.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "92570322-5679-480b-be0d-9fd8c85a8e38"
}