# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Linux VM
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
resource "azurerm_linux_virtual_machine" "tf-linux-vm-01" {
  admin_username                  = "adminuser"
  admin_password                  = var.final_linuxVM_pswd
  disable_password_authentication = false # this must be 'true' if admin_password is not used ie., like when using admin_ssh_keys as an example
  location                        = var.location
  name                            = "tf-linux-vm-01"
  network_interface_ids = [
    var.linuxVM_nic_id
  ]
  resource_group_name = var.rg-test-name
  size                = "Standard_DS1_v2"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  tags = {
    environment = var.environment
  }
}
/*
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Windows VM
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
resource "azurerm_windows_virtual_machine" "tf-windows-vm" {
  name                = "tf-windows-vm"
  resource_group_name = var.rg-Exercise-5a-name
  location            = var.location
  size                = "Standard_F1s"
  admin_username      = "adminuser"
  admin_password      = var.final_windowsVM_pswd
  network_interface_ids = [
    var.windowsVM_private_ip_nw_interface_id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  tags = {
    environment-5a = var.environment-5a
  }
}

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Windows VM Extention used to disable Windows Firewall on the Windows VM [helps opening up ICMP on the WindowsVM as it is disabled by default]
#   If it is not enabled, ping from LinuxVM to WindowsVM will not work unless we manually 'run command' on the WindowsVM from the portal :()
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
resource "azurerm_virtual_machine_extension" "win-vm-extention" {
  name                 = "win-vm-extention"
  virtual_machine_id   = azurerm_windows_virtual_machine.tf-windows-vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  settings             = <<SETTINGS
    {
        "commandToExecute": "NetSh Advfirewall set allprofiles state off"
    }
SETTINGS
}
*/