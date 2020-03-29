resource "azurerm_app_service_plan" "app_service" {
  name = format("service-plan-%s-%s-%03s", var.environment_name, random_string.random.result, var.instance)

  resource_group_name = azurerm_resource_group.app_service.name
  location            = azurerm_resource_group.app_service.location

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    environment = var.environment_name
    instance    = var.instance
  }
}


resource "azurerm_function_app" "app_service" {
  name                      = format("azure-function-%s-%s-%03s", var.environment_name, random_string.random.result, var.instance)
  resource_group_name       = azurerm_resource_group.app_service.name
  location                  = azurerm_resource_group.app_service.location
  app_service_plan_id       = azurerm_app_service_plan.app_service.id
  storage_connection_string = azurerm_storage_account.app_service.primary_connection_string

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  tags = {
    environment = var.environment_name
    instance    = var.instance
  }
}