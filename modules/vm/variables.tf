variable "vm_name" {}
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
variable "subnet_id" {}
variable "vm_size" {
  default = "Standard_B2s"
}
variable "admin_username" {}

variable "tags" {
  type    = map(string)
  default = {}
}