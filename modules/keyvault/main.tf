resource "azurerm_key_vault" "kv" {
  name                       = var.name
  resource_group_name        = var.rg_name
  location                   = var.location
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
}



# Créer tous les secrets passés en map
resource "azurerm_key_vault_secret" "items" {
  for_each     = var.secrets
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.kv.id
}


