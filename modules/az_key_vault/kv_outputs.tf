
output "final_linuxVM_pswd" {
  value     = data.azurerm_key_vault_secret.linuxVM-pswd.value
  sensitive = true
}

output "key-vault-uri" {
  description = "Key Vault URI"
  value       = data.azurerm_key_vault.azkv-name.vault_uri
}