variable "key_vault_name" {
  default = "vault"
}
variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM will be created."
  type        = string
  default     = "Ivan-Candidate"
}
