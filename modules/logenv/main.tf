resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name_prefix}-law"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "env" {
  name                       = "${var.name_prefix}-env"
  resource_group_name        = var.rg_name
  location                   = var.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}


