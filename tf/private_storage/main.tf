terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  version = "=2.3.0"
  features {}
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "source" {
  name     = format("rg_%s_%s_%03s", var.environment_name, random_string.random.result, var.instance)
  location = var.location

  tags = {
    environment = var.environment_name
    instance    = var.instance
  }
}

