terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  version = "=1.44.0"
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "source" {
  name     = format("rg_storage_%s_%s_%03s", var.environment_name, random_string.random.result, var.instance)
  location = var.location

  tags = {
    environment = var.environment_name
    instance    = var.instance
  }
}

