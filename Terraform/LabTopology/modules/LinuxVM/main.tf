resource "azurerm_network_security_group" "vm" {
  name                = var.security_group_name
  location            = var.target_location
  resource_group_name = var.rg_name
  
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
}

resource "azurerm_network_interface" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.target_location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.target_location
  resource_group_name   = var.rg_name
  size                  = "Standard_DS1_v2"
  admin_username        = var.admin_user
  network_interface_ids = [azurerm_network_interface.vm.id]

  admin_ssh_key {
    username = var.admin_user
    public_key = file(var.filename_public_key)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.sku
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

output "private_ip_address" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}