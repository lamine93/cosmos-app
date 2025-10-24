############################
# Location / Global
############################
variable "location" {
  description = "Région Azure pour déployer toutes les ressources."
  type        = string
}

variable "tenant_id" {
  description = "ID du tenant Azure AD (utilisé pour Key Vault)."
  type        = string
}

############################
# Resource Group & Noms
############################
variable "rg_name" {
  description = "Nom du Resource Group."
  type        = string
}

variable "prefix" {
  description = "Préfixe commun pour nommer les ressources (ex: cosmos-aca-dev)."
  type        = string
}

############################
# Azure Container Registry
############################
variable "acr_name" {
  description = "Nom de l’Azure Container Registry (doit être unique globalement, minuscules)."
  type        = string
}

############################
# Azure Key Vault
############################
variable "kv_name" {
  description = "Nom du Key Vault (unique dans la souscription)."
  type        = string
}

############################
# Cosmos DB
############################
variable "cosmos_account" {
  description = "Nom du compte Cosmos DB (unique globalement, minuscules)."
  type        = string
}

variable "cosmos_db" {
  description = "Nom de la base de données Cosmos DB."
  type        = string
}

variable "cosmos_container" {
  description = "Nom du conteneur Cosmos DB."
  type        = string
}

############################
# Container App
############################
variable "app_name" {
  description = "Nom du Container App."
  type        = string
}

variable "image_repo" {
  description = "Nom du repository d'image dans ACR (ex: aca-cosmos)."
  type        = string
}

variable "image_tag" {
  description = "Tag de l'image Docker à déployer."
  type        = string
}


variable  "deploy_app" {
  description = "Déployer l'application Container App (true/false)."
  type        = bool
  default     = true
}