# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.30.0"
    }
  }
  required_version = ">= 1.1.3"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}


# provider "kubernetes" {
#   host = azurerm_kubernetes_cluster.aks.kube_config.0.host
#   client_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
#   client_key = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
#   cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
# }

# data "azurerm_kubernetes_cluster" "aks" {
#   name                = var.aks_name
#   resource_group_name = var.resource_group_name
# }

# provider "kubernetes" {
#   host                   = data.azurerm_kubernetes_cluster.aks.kube_config[0].host
#   cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
#   token                  = data.azurerm_kubernetes_cluster.aks.kube_config[0].access_token
# }