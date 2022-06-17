
output "linux_vm_username" {
  value = azurerm_linux_virtual_machine.tf-linux-vm-01.admin_username
}

output "linuxVM_private_ip_nw_interface_id" {
  value = azurerm_linux_virtual_machine.tf-linux-vm-01
}