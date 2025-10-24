variable "rg_name" {}
variable "location" {}
variable "account_name" {}
variable "db_name"      { default = "appdb" }
variable "container"    { default = "items" }
variable "pk_path"      { default = ["/pk"] }
variable "enable_free_tier" { default = true }