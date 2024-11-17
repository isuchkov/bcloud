resource "azurerm_public_ip" "nginx_ingress" {
  name                = "nginx-ingress-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = "kube-system"

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.nginx_ingress.ip_address
  }
}