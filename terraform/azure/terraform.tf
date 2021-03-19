terraform {
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azurerm/2.52.0
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.52.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.1.0
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
