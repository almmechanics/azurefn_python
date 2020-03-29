resource "azurerm_storage_account" "app_service" {
  name                      = format("function%s%s%03s", var.environment_name, random_string.random.result, var.instance)
  resource_group_name       = azurerm_resource_group.app_service.name
  location                  = azurerm_resource_group.app_service.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true

  tags = {
    environment = var.environment_name
    instance    = var.instance

  }
}