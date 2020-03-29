resource "azurerm_virtual_network" "source" {
  name                = format("storage%s%03s", random_string.random.result, var.instance)
  location            = azurerm_resource_group.source.location
  resource_group_name = azurerm_resource_group.source.name
  address_space       = [var.vnet_cidr]

  subnet {
    name           = "default"
    address_prefix = cidrsubnet(var.vnet_cidr, 8, 1)
  }

  tags = {
    environment = var.environment_name
    instance    = var.instance
  }
}