variable "subscription_id" {
  description = "The subscription id."
  type        = string
  default     = "27c83813-916e-49fa-8d2a-d35332fc8ca4"
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  default     = "Jenkins Server"
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

variable "subnet_id" {
  description = "The ID of the subnet where the virtual machine will be deployed."
  type        = string
  default     = "subnet-1"
}

variable "vm_size" {
  description = "The size of the virtual machine (e.g., Standard_B2s, Standard_D2s_v3)."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "The administrator username for the VM."
  type        = string
  default     = "azureuser"
}

variable "key_vault_name" {
  default = "Ivan-Candidate-vault"
}

variable "acr_name" {
  description = "The Azure registry name."
  type        = string
  default     = "ivancandidateacr"
}

variable "aks_name" {
  description = "The AKS name."
  type        = string
  default     = "ivancandidateaks"
}