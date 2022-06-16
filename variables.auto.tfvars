# * * * * * * * * * * * *
# Project Constants
location = "Australia East"

# * * * * * * * * * * * *
# Resource Group

environment              = "Test Environment"
vnet1-address-space      = ["10.1.0.0/16"]
vnet1-subnet1-address    = ["10.1.0.0/24"]
azbastion-subnet-address = ["10.1.1.0/26"]
azb_scl_units            = 2

firewall_allocation_method = "Static" # When the sku is default 'Basic',  allocation method 'Dynamic' works but for 'Standard', it has to be a 'Static'
firewall_sku               = "Standard"