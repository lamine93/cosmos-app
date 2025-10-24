terraform {
     backend "azurerm" {
          resource_group_name="rg-tfstate"
          storage_account_name="statetf7742b0d9"
          container_name="tfstate"
          key="infra.terraform.tfstate"
          access_key = ""
     } 
}
