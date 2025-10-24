output "rg_name"            { value = module.rg.name }
output "location"           { value = module.rg.location }

output "acr_id"             { value = module.acr.id}
output "acr_login_server"   { value = module.acr.login_server }

output "aca_env_id"         { value = module.logenv.env_id }

output "kv_id"              { value = module.kv.id }
output "kv_secret_ids" {
  value = module.kv.secret_ids
  sensitive = true
}

output "cosmos_db"          { value = module.cosmos.db_name }
output "cosmos_container"   { value = module.cosmos.container }

output "rg_id" { value = module.rg.id }

