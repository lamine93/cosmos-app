variable "rg_name" {}
variable "env_id" {}
variable "acr_login_server" {}
variable "app_name"        {}
variable "image_ref"       {default = "nginx:latest"} # ex: "<acr>.azurecr.io/aca-cosmos:<tag>"
variable "target_port"     { default = 80 }
variable "secrets_from_kv" { type = map(string) } # map nomSecret -> key_vault_secret_id
variable "env_plain" {
  type    = map(string)
  default = {}
} # env non secrets