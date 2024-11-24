variable "aks_name" {
  description = "The AKS name."
  type        = string
  default     = "ivancandidateaks"
}
variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "node_count" {
  description = "AKS node count"
  type        = string
  default     = "1"
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM will be created."
  type        = string
  default     = "Ivan-Candidate"
}

variable "dns_prefix" {
  default     = "ivancandidate"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to deploy"
  default     = "1.30.6"
}