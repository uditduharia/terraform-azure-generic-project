terraform {
  backend "azurerm" {
    resource_group_name  = "rg-demo"
    storage_account_name = "straccdemo1"
    container_name       = "straccdemo1container"
    key                  = "terraform.tfstate"
  }
}