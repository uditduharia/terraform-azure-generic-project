variable "vm" {
  type = map(object({
    name                = string
    nic_name            = string
    location            = string
    resource_group_name = string
    vm_size             = string
    subnet_id           = string
    admin_username      = string
    admin_password      = string
  }))
}