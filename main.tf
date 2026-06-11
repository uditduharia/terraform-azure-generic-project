module "rg" {
  source   = "./modules/rg"
  name     = var.rg_name
  location = var.location
}





module "vnet" {
  source = "./modules/vnet"

  vnet = {
    vnet1 = {
      name                = "vnet-1"
      address_space       = ["10.0.0.0/16"]
      location            = var.location
      resource_group_name = module.rg.rg_name
    }

    vnet2 = {
      name                = "vnet-2"
      address_space       = ["10.1.0.0/16"]
      location            = var.location
      resource_group_name = module.rg.rg_name
    }
  }
}





module "subnet" {
  source = "./modules/subnet"

  depends_on = [module.vnet]

  subnet = {
    subnet1 = {
      name                 = "subnet-linux"
      resource_group_name  = module.rg.rg_name
      virtual_network_name = "vnet-1"
      address_prefixes     = ["10.0.1.0/24"]
    }

    subnet2 = {
      name                 = "subnet-windows"
      resource_group_name  = module.rg.rg_name
      virtual_network_name = "vnet-2"
      address_prefixes     = ["10.1.1.0/24"]
    }
  }
}





module "linux_vm" {
  source = "./modules/linux-vm"

  vm = {
    linux1 = {
      name                = "linux-vm"
      nic_name            = "linux-nic"
      location            = var.location
      resource_group_name = module.rg.rg_name
      vm_size = "Standard_D2s_v3"

      subnet_id = module.subnet.subnet_ids["subnet1"]

      admin_username = "azureuser"
      admin_password = "Password1234!"
    }
  }
}





module "windows_vm" {
  source = "./modules/windows-vm"

  vm = {
    win1 = {
      name                = "windows-vm"
      nic_name            = "windows-nic"
      location            = var.location
      resource_group_name = module.rg.rg_name
      vm_size = "Standard_D2s_v3"

      subnet_id = module.subnet.subnet_ids["subnet2"]

      admin_username = "azureuser"
      admin_password = "Password1234!"
    }
  }
}





