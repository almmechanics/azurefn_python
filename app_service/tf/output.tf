output "resource_group_name" {
  value = azurerm_resource_group.app_service.name
}

output "app_name" {
  value = azurerm_function_app.app_service.name
}