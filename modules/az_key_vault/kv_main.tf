
data "azurerm_client_config" "current-config" {}

resource "random_password" "rndm-pswd" {
  length           = 18
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 4
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault" "azkv-name" {
  name                        = "az-kv-name"
  location                    = var.location
  resource_group_name         = var.rg-test-name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current-config.tenant_id
  soft_delete_retention_days  = 7
  sku_name                    = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current-config.tenant_id
    object_id = data.azurerm_client_config.current-config.object_id

    key_permissions = ["Create", "Get", "List", "Encrypt", "Update", "Decrypt", "Sign", "UnwrapKey", "Delete", "Purge", "Recover", "Restore", "Backup",
    "Verify", "Restore", "WrapKey"]
    secret_permissions  = ["Get", "Set", "List", "Delete", "Purge", "Recover", "Restore", "Backup"]
    storage_permissions = ["Get", "List", "Update", "Purge", "Delete", "Set", "Backup"]
  }
  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
  tags = {
    environment = var.environment
    name        = "Azure Key Vault"
  }
}

resource "azurerm_key_vault_secret" "linuxVM-pswd" {
  name         = "linuxVM-pswd"
  value        = "${var.prefix}-${random_password.rndm-pswd.result}"
  key_vault_id = azurerm_key_vault.azkv-name.id
  depends_on = [
    azurerm_key_vault.azkv-name,
  ]
}

data "azurerm_key_vault_secret" "linuxVM-pswd" {
  name         = "linuxVM-pswd"
  key_vault_id = azurerm_key_vault.azkv-name.id
}

data "azurerm_key_vault" "azkv-name" {
  name                = azurerm_key_vault.azkv-name.name
  resource_group_name = var.rg-test-name
}