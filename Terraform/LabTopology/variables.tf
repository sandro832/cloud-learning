
variable "location" {
  type = string
  description = "The Azure Region in which all resources in this example should be created."
}

variable "jumphost_address" {
  type = string
}

variable "admin_user" {
  type = string
  description = "admin user for host"
}

variable "filename_public_key"{
    type = string
}

variable "rg_name"{
    type = string
}

variable "linux_distro"{
    type = string
}







