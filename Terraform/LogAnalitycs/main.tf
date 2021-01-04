terraform {
  required_version = ">=0.12.7"
}

provider "azurerm" {
  version = ">=2.2.0"
  features {}
  subscription_id = "68357aff-7637-4771-b196-1f5606d4e8a3"
}

resource "azurerm_resource_group" "rg" {
 name     = var.rg_name
 location = var.target_location
}

resource "azurerm_storage_account" "stg" {
  name                     = var.vm_data_account
  resource_group_name      = var.rg_name
  location                 = var.target_location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "ZRS"

  enable_https_traffic_only = true

  depends_on = [
    azurerm_resource_group.rg
  ]
}

// ************************************************************************************ 
// VNET Hub 
// ************************************************************************************ 

resource "azurerm_virtual_network" "hub" {
  name                = "ps-hub-vnet"
  resource_group_name = var.rg_name
  location            = var.target_location

  address_space       = ["10.1.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]   
}

resource "azurerm_subnet" "subnetHA" {
  name                  = "subnet-ha"
  resource_group_name   = var.rg_name
  virtual_network_name  = azurerm_virtual_network.hub.name
  address_prefixes      = ["10.1.2.0/24"]
}

// ************************************************************************************ 
// Virtual Machines
// ************************************************************************************

module "client" {
  source = "./modules/WindowsVM"
  for_each = var.clients

  vm_name               = each.value.name
  
  vm_size               = "Standard_DS1_v2"
  sku                   = "2016-Datacenter"

  rg_name               = var.rg_name
  target_location       = var.target_location

  admin_username        = "chief"
  admin_password        = "TreatyQuestionSequelDelta1.@"
  
  security_group_name = each.value.sec_group_name
  jumphost_address = "192.168.1.8"

  subnet_id = azurerm_subnet.subnetHA.id

  depends_on = [
      azurerm_resource_group.rg,
      azurerm_virtual_network.hub
  ]  
}
