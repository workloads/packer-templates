output "resource_group_name" {
  description = "Resource Group Name"
  value       = azurerm_resource_group.packer.name
}

output "resource_group_location" {
  description = "Resource Group Location"
  value       = azurerm_resource_group.packer.location
}

output "resource_group_url" {
  description = "Resource Group URL for Azure Portal"
  value       = "https://portal.azure.com/#/resource${azurerm_resource_group.packer.id}/overview"
}
