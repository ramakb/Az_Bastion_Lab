
terraform {
  backend "azurerm" {
    resource_group_name  = "rgtfstatefiles"
    storage_account_name = "tfstatesacnt"
    container_name       = "tfstate-container"
    key                  = "Azure_Bastion_Lab.terraform.tfstate"
  }
}