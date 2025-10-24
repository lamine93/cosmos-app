resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_resource_group" "state" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_storage_account" "state" {
  name                     = "${var.storage_account_name}${random_id.suffix.hex}"
  resource_group_name      = azurerm_resource_group.state.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public   = false
}

resource "azurerm_storage_container" "state" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
}
