
resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
}

# # * * * * * * *  module resource_groups is used to build Resource Groups [Primary and Secondary] * * * * * * *
module "resource_groups" {
  source      = "./modules/resource_groups"
  location    = var.location
  environment = var.environment
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

# # * * * * * * *  module virtual_networks is used for creating vnets in each Resource Group * * * * * * *
module "virtual_networks" {
  source                     = "./modules/virtual_networks"
  location                   = var.location
  environment                = var.environment
  rg-test-name               = module.resource_groups.rg-test-name
  firewall_allocation_method = var.firewall_allocation_method
  firewall_sku               = var.firewall_sku
  vnet1-address-space        = var.vnet1-address-space
  vnet1-subnet1-address      = var.vnet1-subnet1-address
  depends_on                 = [module.resource_groups, time_sleep.wait_30_seconds]
}

# # * * * * * * *  module resource_groups is used to build Resource Groups [Primary and Secondary] * * * * * * *
module "az_bastion" {
  source                     = "./modules/az_bastion"
  location                   = var.location
  environment                = var.environment
  rg-test-name               = module.resource_groups.rg-test-name
  firewall_allocation_method = var.firewall_allocation_method
  firewall_sku               = var.firewall_sku
  tf_vnet1_name              = module.virtual_networks.tf_vnet1_name
  vnet1-address-space        = var.vnet1-address-space
  azbastion-subnet-address   = var.azbastion-subnet-address
  azb_scl_units              = var.azb_scl_units
  depends_on                 = [module.resource_groups, module.virtual_networks, time_sleep.wait_30_seconds]
}


# # * * * * * * *  module vm is used for creating Virtual Machines in each of the RGs * * * * * * *
module "vm" {
  source             = "./modules/vm"
  location           = var.location
  environment        = var.environment
  rg-test-name       = module.resource_groups.rg-test-name
  linuxVM_nic_id     = module.virtual_networks.linuxVM_nic_id
  final_linuxVM_pswd = module.az_key_vault.final_linuxVM_pswd
  depends_on         = [module.virtual_networks, module.az_key_vault, time_sleep.wait_30_seconds]
}

# # * * * * * * *  module traffic_rules is used for setting up different NSGs/Security Rules to control the traffic flow * * * * * * *
module "traffic_rules" {
  source                   = "./modules/traffic_rules"
  location                 = var.location
  environment              = var.environment
  rg-test-name             = module.resource_groups.rg-test-name
  AzureBastionSubnet-id    = module.az_bastion.AzureBastionSubnet-id
  subnet_with_LinuxVM_id   = module.virtual_networks.subnet_with_LinuxVM_id
  linuxVM_nic_id           = module.virtual_networks.linuxVM_nic_id
  azbastion-subnet-address = var.azbastion-subnet-address
  depends_on               = [module.resource_groups, module.vm, module.virtual_networks, module.az_bastion, time_sleep.wait_30_seconds]
}

# # * * * * * * *  module for Azure Key Vault * * * * * * *
module "az_key_vault" {
  source       = "./modules/az_key_vault"
  location     = var.location
  environment  = var.environment
  rg-test-name = module.resource_groups.rg-test-name
  depends_on   = [module.resource_groups, time_sleep.wait_30_seconds]
}
