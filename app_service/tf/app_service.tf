resource "azurerm_app_service_plan" "app_service" {
  name = format("service-plan-%s-%s-%03s", var.environment_name, random_string.random.result, var.instance)

  resource_group_name = azurerm_resource_group.app_service.name
  location            = azurerm_resource_group.app_service.location
  kind                = "Linux"
  reserved            = true

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
  os_type                   = "linux"
  version                   = "~3"

  app_settings = {
    SHARED_ACCESS_SIGNATURE     = "SharedAccessSignature=${data.azurerm_storage_account_sas.source.sas};BlobEndpoint=https://${data.azurerm_storage_account.source.name}.blob.core.windows.net/;"
    FUNCTIONS_EXTENSION_VERSION = "~3"
    FUNCTIONS_WORKER_RUNTIME    = "python"
    site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }           = data.azurerm_storage_account.source.primary_connection_string
  }

  site_config {
    always_on = true
  }

  tags = {
    environment = var.environment_name
    instance    = var.instance
  }
}