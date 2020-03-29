resource "azurerm_subnet" "storage" {
  name                 = format("storage%s%s%03s", var.environment_name, random_string.random.result, var.instance)
  resource_group_name  = azurerm_resource_group.source.name
  virtual_network_name = azurerm_virtual_network.source.name
  address_prefix       = cidrsubnet(var.vnet_cidr, 8, 2)
  service_endpoints    = ["Microsoft.Storage"]
}



resource "azurerm_storage_account" "source" {
  name                      = format("storage%s%s%03s", var.environment_name, random_string.random.result, var.instance)
  resource_group_name       = azurerm_resource_group.source.name
  location                  = azurerm_resource_group.source.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = [azurerm_subnet.storage.id]
  }

  tags = {
    environment = var.environment_name
    instance    = var.instance

  }
}