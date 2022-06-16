# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Create Azure Bastion Host, Subnet, Public IP 
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# Create AzureBastionSubnet
resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg-test-name
  virtual_network_name = var.tf_vnet1_name
  address_prefixes     = var.azbastion-subnet-address
}

# Create PublicIP for Azure Bastion
resource "azurerm_public_ip" "azb-publicIP" {
  name                = "azb-publicIP"
  location            = var.location
  resource_group_name = var.rg-test-name
  allocation_method   = var.firewall_allocation_method
  sku                 = var.firewall_sku
}

# Create Azure Bastion Host
resource "azurerm_bastion_host" "azb-host" {
  name                = "azb-host"
  location            = var.location
  resource_group_name = var.rg-test-name
  scale_units         = var.azb_scl_units

  ip_configuration {
    name                 = "azb-Ip-configuration"
    subnet_id            = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.azb-publicIP.id
  }
  tags = {
    "solution"  = "Azure Bastion Service"
    environment = var.environment
  }
}