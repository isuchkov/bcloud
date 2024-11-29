data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Create a Static Public IP for NGINX Ingress
resource "azurerm_public_ip" "nginx_ingress" {
  name                = "nginx-ingress-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

# Kubernetes Namespace for Ingress
resource "kubernetes_namespace" "dns" {
  metadata {
    name = var.ingress_namespace
  }
}

# Helm Release for NGINX Ingress Controller
resource "helm_release" "ingress" {
  name       = "ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.ingress_namespace
  version    = "4.11.3"

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.nginx_ingress.ip_address
  }
}

# Azure DNS Zone
resource "azurerm_dns_zone" "aks_dns_zone" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name
}

# # User Assigned Identity for ExternalDNS
# resource "azurerm_user_assigned_identity" "aks_dns_identity" {
#   name                = "aks-dns-identity"
#   resource_group_name = var.resource_group_name
#   location            = var.location
# }
#
# # Federated Identity for ExternalDNS
# resource "azurerm_federated_identity_credential" "default" {
#   name                = var.ingress_namespace
#   resource_group_name = var.resource_group_name
#   audience            = ["api://AzureADTokenExchange"]
#   issuer              = var.aks_cluster_oidc_issuer_url
#   parent_id           = azurerm_user_assigned_identity.aks_dns_identity.id
#   subject             = "system:serviceaccount:${var.ingress_namespace}:external-dns"
# }
#
# # Role Assignments for Azure DNS Zone and Resource Group
# resource "azurerm_role_assignment" "aks_dns_role_assignment" {
#   scope                = azurerm_dns_zone.aks_dns_zone.id
#   role_definition_name = "DNS Zone Contributor"
#   principal_id         = azurerm_user_assigned_identity.aks_dns_identity.principal_id
# }
#
# resource "azurerm_role_assignment" "aks_rg_reader_role_assignment" {
#   scope                = data.azurerm_resource_group.rg.id
#   role_definition_name = "Reader"
#   principal_id         = azurerm_user_assigned_identity.aks_dns_identity.principal_id
# }
#
# AzureAD Application for Service Principal
resource "azuread_application" "external_dns_app" {
  display_name = "spn-external-dns-aks"
}
#
# resource "azuread_service_principal" "external_dns_sp" {
#   client_id = azuread_application.external_dns_app.client_id
# }
#
# resource "azuread_service_principal_password" "external_dns_sp_password" {
#   service_principal_id = azuread_service_principal.external_dns_sp.id
# }