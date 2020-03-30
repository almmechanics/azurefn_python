data "azurerm_storage_account" "source" {
  name                = var.data_source_name
  resource_group_name = var.data_source_rg_name
}

data "azurerm_storage_account_sas" "source" {
  connection_string = data.azurerm_storage_account.source.primary_connection_string
  https_only        = true
  resource_types {
    service   = true
    container = false
    object    = false
  }
  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }
  start  = timeadd(timestamp(), "-1h")
  expiry = timeadd(timestamp(), format("%sh", var.expiry_hours))

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
  }
}