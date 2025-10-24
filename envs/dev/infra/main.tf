resource "random_id" "suffix" {
  byte_length = 3
}

module "rg" {
  source   = "../../../modules/rg"
  name     = var.rg_name
  location = var.location
}

module "acr" {
  source   = "../../../modules/acr"
  rg_name  = module.rg.name
  location = module.rg.location
  name     = "${var.acr_name}${var.prefix}${random_id.suffix.hex}"
}

module "logenv" {
  source      = "../../../modules/logenv"
  rg_name     = module.rg.name
  location    = module.rg.location
  name_prefix = var.prefix
}

module "cosmos" {
  source           = "../../../modules/cosmos"
  rg_name          = module.rg.name
  location         = module.rg.location
  account_name     = "${var.cosmos_account}${var.prefix}${random_id.suffix.hex}"
  db_name          = var.cosmos_db
  container        = var.cosmos_container
  enable_free_tier = true
}

module "kv" {
  source    = "../../../modules/keyvault"
  rg_name   = module.rg.name
  location  = module.rg.location
  tenant_id = var.tenant_id
  terraform_sp_object_id = data.azuread_service_principal.sp.object_id
  name      = "${var.kv_name}${var.prefix}${random_id.suffix.hex}"
  secrets = {
    COSMOS-ENDPOINT = module.cosmos.endpoint
    COSMOS-KEY      = module.cosmos.primary_key
  }
}

# module "app" {
#   source            = "../../../modules/aca_app"
#   deploy_app        = var.deploy_app
#   rg_name           = module.rg.name
#   env_id            = module.logenv.env_id
#   acr_login_server  = module.acr.login_server
#   app_name          = var.app_name
#   image_ref         = "${module.acr.login_server}/${var.image_repo}:${var.image_tag}"
#   target_port       = 8080
#   env_plain = {
#     COSMOS_DB        = var.cosmos_db
#     COSMOS_CONTAINER = var.cosmos_container
#   }
#   secrets_from_kv = {
#     COSMOS_ENDPOINT = module.kv.secret_ids["COSMOS-ENDPOINT"]
#     COSMOS_KEY      = module.kv.secret_ids["COSMOS-KEY"]
#   }
# }

