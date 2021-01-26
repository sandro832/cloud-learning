variable "rg_name" {
 type = string
 description = "resource group name"   
}

variable "target_location" {
 type = string
 description = "Azure location"   
}

variable "vm_name" {
 type = string
 description = "the VM machine name"
}

variable "subnet_id" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "jumphost_address" {
  type = string
}

variable "admin_username" {
    type = string
}

variable "filename_public_key" {
    type = string
}

variable "sku" {
    type = string
}