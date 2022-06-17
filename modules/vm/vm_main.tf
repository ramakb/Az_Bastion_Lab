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