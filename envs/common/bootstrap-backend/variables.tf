variable "location" {
  description = "Région Azure"
  type        = string
  default     = "francecentral"
}

variable "rg_name" {
  description = "Resource Group pour stocker le backend"
  type        = string
  default     = "rg-tfstate"
}

variable "storage_account_name" {
  description = "Nom du Storage Account (globalement unique, minuscules)"
  type        = string
  default     = "statetf"
}

variable "container_name" {
  description = "Nom du container blob pour le state"
  type        = string
  default     = "tfstate"
}
