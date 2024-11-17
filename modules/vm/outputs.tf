output "public_ip" {
  value = azurerm_public_ip.vm_public_ip.ip_address
}
output "tls_private_key" {
  value     = tls_private_key.secureadmin_ssh.private_key_pem
  sensitive = true
}