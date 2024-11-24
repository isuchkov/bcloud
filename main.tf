# Resource Group
# resource "azurerm_resource_group" "main" {
#   name     = var.resource_group_name
#   location = var.location
# }

# Create virtual network and subnet
resource "azurerm_virtual_network" "vnet" {
  name                = "main-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "default-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# VM
module "vm" {
  source              = "./modules/vm"
  vm_name             = "jenkins-server"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet.id
  admin_username      = var.admin_username
  tags = {
    environment = "dev"
  }
}

# Module: Azure Kubernetes Service
module "aks" {
  source              = "./modules/aks"
  aks_name            = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Module: Key Vault
module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# resource "azurerm_kubernetes_cluster_key_vault_secrets_provider" "kv_provider" {
#   kubernetes_cluster_id = module.aks.azurerm_kubernetes_cluster.aks.id
#
#   secret {
#     name          = var.secret_name
#     key_vault_url = module.key_vault.azurerm_key_vault.vault.vault_uri
#   }
# }

# Module: Azure Container Registry
module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "external-dns" {
  source              = "./modules/external-dns"
  kube_host                   = module.aks.kube_config.host
  kube_cluster_ca_certificate = module.aks.kube_config.cluster_ca_certificate
  kube_client_certificate     = module.aks.kube_config.client_certificate
  kube_client_key             = module.aks.kube_config.client_key
}


# # HPA
# module "hpa" {
#   source           = "./modules/hpa"
#   hpa_name         = "hello-world-hpa"
#   namespace        = "default"
#   deployment_name  = "hello-world-app"
#   min_replicas     = 1
#   max_replicas     = 5
#   cpu_threshold    = 75
#   memory_threshold = 80
# }
#
# # Redis Sentinel
# module "redis" {
#   source    = "./modules/redis"
#   namespace = "default"
# }
#
# # NGINX Ingress
# module "nginx" {
#   source            = "./modules/nginx"
# }
