# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Resource Groups's Virtual Netowrk and LinuxVM ####
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# Create a VNet
resource "azurerm_virtual_network" "tf-vnetwork-01" {
  name                = "tf-vnetwork-01"
  location            = var.location
  resource_group_name = var.rg-test-name
  address_space       = var.vnet1-address-space

  tags = {
    environment = var.environment
    "Network"   = "tf-network-01"
  }
}

# Create a Subnet
resource "azurerm_subnet" "vnet1-subnet1" {
  name                 = "vnet1-subnet1"
  resource_group_name  = var.rg-test-name
  virtual_network_name = azurerm_virtual_network.tf-vnetwork-01.name
  address_prefixes     = var.vnet1-subnet1-address
}

# Create a NIC for LinuxVM
resource "azurerm_network_interface" "linuxVM-PrivIP-nic" {
  location            = var.location
  name                = "linuxVM-PrivIP-nic"
  resource_group_name = var.rg-test-name
  ip_configuration {
    name      = "linuxVM-PrivIP-nic-ipConfig"
    subnet_id = azurerm_subnet.vnet1-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    environment = var.environment
  }
}