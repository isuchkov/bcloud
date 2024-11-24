variable "acr_name" {
  description = "The Azure registry name."
  type        = string
  default     = "ivancandidateacr"
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
