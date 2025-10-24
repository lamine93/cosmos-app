output "endpoint"    { value = azurerm_cosmosdb_account.acc.endpoint }
output "primary_key" { value = azurerm_cosmosdb_account.acc.primary_key }
output "db_name"     { value = azurerm_cosmosdb_sql_database.db.name }
output "container"   { value = azurerm_cosmosdb_sql_container.ct.name }