output "id"        { value = azurerm_key_vault.kv.id }
output "secret_ids" {
  value = { for k,v in azurerm_key_vault_secret.items : k => v.id }
}