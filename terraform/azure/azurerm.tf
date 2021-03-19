provider "azurerm" {
  features {}
}

# create an Azure Resource Group for use with Packer
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "packer" {
  name     = "${var.resource_group_name}-${random_string.string.id}"
  location = var.resource_group_location
}
