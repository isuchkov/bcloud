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

variable "domain_name" {
  description = "The domain name for the DNS zone."
  type        = string
  default     = "ivancandidate.com"
}

variable "ingress_namespace" {
  description = "The namespace for ingress."
  type        = string
  default     = "dns"
}

variable "subscription_id" {
  description = "Azure Subscription ID."
  type        = string
  default = "27c83813-916e-49fa-8d2a-d35332fc8ca4"
}

variable "tenant_id" {
  description = "Azure Tenant ID."
  type        = string
  default     = "bd4f0481-b137-40f1-9e64-20cfd55fbf49"
}

variable "aks_cluster_oidc_issuer_url" {
  description = "The OIDC issuer URL for the AKS cluster."
  type        = string
  default = "https://ivancandidate-5o727fg5.eastus.aks.azure.com/identity"
}

variable "kube_host" {
  description = "The Kubernetes API server URL"
  type        = string
  default     = "https://ivancandidate-5o727fg5.hcp.eastus.azmk8s.io:443"
}

variable "kube_cluster_ca_certificate" {
  description = "The base64-encoded Kubernetes cluster CA certificate"
  type        = string
}

variable "kube_client_certificate" {
  description = "The base64-encoded Kubernetes client certificate"
  type        = string
}

variable "kube_client_key" {
  description = "The base64-encoded Kubernetes client key"
  type        = string
}