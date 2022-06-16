
output "tf_vnet1_id" {
  value = azurerm_virtual_network.tf-vnetwork-01.id
}
output "tf_vnet1_name" {
  value = azurerm_virtual_network.tf-vnetwork-01.name
}

output "subnet_with_LinuxVM_id" {
  value = azurerm_subnet.vnet1-subnet1.id
}

output "linuxVM_nic_id" {
  value = azurerm_network_interface.linuxVM-PrivIP-nic.id
}

