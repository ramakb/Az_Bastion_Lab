# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Resource Group
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# Create a Resource Group
resource "azurerm_resource_group" "rg-test-name" {
  location = var.location
  name     = "rg-test-name"

  tags = {
    environment = var.environment
    name        = "Test Resource Group"
  }
}

data "azurerm_resource_group" "rg-test-name" {
  name = azurerm_resource_group.rg-test-name.name
}