
resource "azurerm_network_security_group" "vm" {
  name                  = var.security_group_name
  resource_group_name   = var.rg_name
  location              = var.target_location

  security_rule {
    name                       = "jumphost"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.jumphost_address
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.target_location

  ip_configuration {
    name                          = var.vm_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name
  location              = var.target_location
  network_interface_ids = [azurerm_network_interface.vm.id]
  size                  = "Standard_DS1_v2"
  admin_username        = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.filename_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.sku
    version   = "latest"
  }
}

resource "azurerm_network_interface_security_group_association" "vm" {
  network_interface_id       = azurerm_network_interface.vm.id
  network_security_group_id  = azurerm_network_security_group.vm.id
} 

output "private_ip_address" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}