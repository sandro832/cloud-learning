variable "rg_name" {
 type = string
}

variable "target_location" {
 type = string
}

variable "vm_data_account" {
 type = string
 description = "storage account for boot diagnostics and such"
}

variable "clients" {
  type = map(object({
    name = string
    sec_group_name = string
  }))
  description = "VMs."
}