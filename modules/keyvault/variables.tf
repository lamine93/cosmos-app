variable "rg_name" {}
variable "location" {}
variable "tenant_id" {}
variable "terraform_sp_object_id" {}
variable "name" {}
variable "secrets" { type = map(string) } # { COSMOS-ENDPOINT = "...", COSMOS-KEY = "..." }