terraform {
  required_version = ">=0.12.7"
}

provider "azurerm" {
  version = ">=2.20.0"
  features {}
  subscription_id = "e67a50bc-70b2-4838-8598-c9fb1880a4ac"
}

resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.location
}

//######################################################################
//Vnet-hub
//######################################################################

resource "azurerm_virtual_network" "hub" {
  name                = "ps-hub-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  depends_on          = [azurerm_resource_group.main]
}

resource "azurerm_virtual_network_peering" "hub" {
  name                         = "peer1to2"
  resource_group_name          = azurerm_resource_group.main.name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_subnet" "subnetHA" {
  name                 = "subnet-ha"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "subnetHB" {
  name                 = "subnet-HB"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.3.0/24"]
}

resource "azurerm_subnet" "AzureFirewallSubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.1.0/24"]
}

//######################################################################
//Vnet-spoke
//######################################################################

resource "azurerm_virtual_network" "spoke" {
  name                = "ps-spoke-vnet"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  depends_on          = [azurerm_resource_group.main]
}

resource "azurerm_virtual_network_peering" "spoke" {
  name                         = "peer2to1"
  resource_group_name          = azurerm_resource_group.main.name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_subnet" "subnetSA" {
  name                 = "subnet-sa"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = ["10.2.1.0/24"]
}

//####################################################################################
//Firewall
//####################################################################################

resource "azurerm_public_ip" "firewall" {
  name                = "firewall"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on          = [azurerm_resource_group.main]
}

resource "azurerm_firewall" "firewall" {
  name                = "firewall"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  depends_on          = [azurerm_resource_group.main]
  
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

output "firewall_public_ip" {
  value = azurerm_public_ip.firewall.ip_address
}

//####################################################################################
//Application Rule
//####################################################################################

resource "azurerm_firewall_application_rule_collection" "firewall" {
  name                = "hub"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.main.name
  depends_on          = [azurerm_resource_group.main]
  priority            = 100
  action              = "Allow"

  rule {
    name = "google"

    source_addresses = [
      "10.1.0.0/16",
    ]

    target_fqdns = [
      "*.google.com",
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}

//####################################################################################
//Network Rule
//####################################################################################

resource "azurerm_firewall_network_rule_collection" "firewall" {
  name                = "hub"
  resource_group_name = azurerm_resource_group.main.name
  azure_firewall_name = azurerm_firewall.firewall.name
  depends_on          = [azurerm_resource_group.main]
  priority            = 100
  action              = "Allow"
  
  rule {
    name = "dns"

    source_addresses = [
      "10.1.0.0/16",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "209.244.0.3",
      "209.244.0.4",
    ]
   
   protocols = [
      "TCP",
      "UDP",
    ]
    
  }
}

//####################################################################################
//Nat Rule
//####################################################################################

resource "azurerm_firewall_nat_rule_collection" "firewall" {
  name                = "rdp"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.main.name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "rdp"

    source_addresses = [
      "193.134.170.35/32",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      azurerm_public_ip.firewall.ip_address
    ]

    translated_port = 22

    translated_address = module.angelina.private_ip_address


    protocols = [
      "TCP",
      "UDP",
    ]
  } 
    depends_on = [azurerm_resource_group.main]
}    

// ######################################################################################
// Virtual Machines 
// ######################################################################################

module "angelina" {
  source                                    = "./modules/LinuxVM"
  vm_name                                   = "angelina"
  sku                                       = var.linux_distro
  rg_name                                   = var.rg_name
  target_location                           = var.location
  admin_user                                = var.admin_user
  filename_public_key                       = var.filename_public_key
  security_group_name                       = "nsg1"
  jumphost_address                          = var.jumphost_address
  subnet_id                                 = azurerm_subnet.subnetHA.id
  depends_on                                = [azurerm_resource_group.main, azurerm_virtual_network.hub
  ]
}

module "luna"{
  source                                    = "./modules/LinuxVM"
  vm_name                                   = "luna"
  sku                                       = var.linux_distro
  rg_name                                   = var.rg_name
  target_location                           = var.location
  admin_user                                = var.admin_user
  filename_public_key                       = var.filename_public_key
  security_group_name                       = "nsg3"
  jumphost_address                          = var.jumphost_address
  subnet_id                                 = azurerm_subnet.subnetSA.id
  depends_on                                = [azurerm_resource_group.main, azurerm_virtual_network.spoke
  ]
}

module "ruby"{
  source                                    = "./modules/LinuxVM"
  vm_name                                   = "ruby"
  sku                                       = var.linux_distro
  rg_name                                   = var.rg_name
  target_location                           = var.location
  admin_user                                = var.admin_user
  filename_public_key                       = var.filename_public_key
  security_group_name                       = "nsg2"
  jumphost_address                          = var.jumphost_address
  subnet_id                                 = azurerm_subnet.subnetSA.id
  depends_on                                = [azurerm_resource_group.main, azurerm_virtual_network.spoke
  ]
}


//########################################################################################
//Route Table
//########################################################################################

resource "azurerm_route_table" "subnetHA" {
  name                          = "subnetHA"
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  disable_bgp_route_propagation = false

  route {
    name                  = "internet"
    address_prefix        = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }  
}

resource "azurerm_subnet_route_table_association" "subnetHA" {
  subnet_id      = azurerm_subnet.subnetHA.id
  route_table_id = azurerm_route_table.subnetHA.id
}

resource "azurerm_route_table" "subnetHB" {
  name                          = "subnetHB"
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  disable_bgp_route_propagation = false

  route {
    name                  = "internet"
    address_prefix        = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }  
}

resource "azurerm_subnet_route_table_association" "subnetHB" {
  subnet_id      = azurerm_subnet.subnetHB.id
  route_table_id = azurerm_route_table.subnetHB.id
}

resource "azurerm_route_table" "subnetSA" {
  name                          = "subnetSA"
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  disable_bgp_route_propagation = false

  route {
    name                  = "internet"
    address_prefix        = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }  
}

resource "azurerm_subnet_route_table_association" "subnetSA" {
  subnet_id      = azurerm_subnet.subnetSA.id
  route_table_id = azurerm_route_table.subnetSA.id
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

resource "azurerm_network_security_group" "nsg4" {
  name                = "nsg4"
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
}

resource "azurerm_subnet_network_security_group_association" "nsg4" {
  subnet_id                 = azurerm_subnet.subnetSA.id
  network_security_group_id = azurerm_network_security_group.nsg4.id
}


