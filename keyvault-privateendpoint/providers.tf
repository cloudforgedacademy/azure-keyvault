terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}


provider "azurerm" {
  alias = ""
  features {}
  subscription_id = "fcaaa221-c24a-4467-9dc7-7a03d368df4e"

}