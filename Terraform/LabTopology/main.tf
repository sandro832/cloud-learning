terraform {
  required_version = ">=0.12.7"
}

provider "azurerm" {
  version = "=2.20.0"
 features {}
 subscription_id = "e67a50bc-70b2-4838-8598-c9fb1880a4ac"
}

resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "hub" {
  name                = "ps-hub-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  depends_on = [azurerm_resource_group.main]
}

resource "azurerm_subnet" "subnetHA" {
  name                 = "subnet-ha"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_network_interface" "angelina" {
  name                = "angelina"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetHA.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "angelina"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_DS1_v2"
  admin_username                  = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.angelina.id,
  ]

  admin_ssh_key {
    username = "adminuser"
    public_key = file("C:\\SRDEV\\Keys\\2020-Q4-Pub.txt")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "nsg1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
   security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "193.134.170.35"
    destination_address_prefix = "*"
  }
  
  depends_on =[azurerm_resource_group.main]

}

resource "azurerm_public_ip" "example" {
  name                = "PubLab"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}