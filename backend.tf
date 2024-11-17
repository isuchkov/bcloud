terraform {
  backend "azurerm" {
    resource_group_name  = "Ivan-Candidate"
    storage_account_name = "terraformbackendsaivans"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate" # State file name
  }
}
