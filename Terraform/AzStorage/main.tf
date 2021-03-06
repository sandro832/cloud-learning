terraform {
  required_version = ">=0.12.7"
}

provider "azurerm" {
 features {}
}

resource "azurerm_resource_group" "rg" {
 name     = var.rg_name
 location = "westeurope"
}

resource "azurerm_storage_account" "stg" {
  name                     = var.account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "ZRS"

  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "blob" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.stg.name
  container_access_type = "private"
}