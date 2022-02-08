terraform {
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.95.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/local/2.1.0
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.1.0
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  required_version = "1.1.5"
}
