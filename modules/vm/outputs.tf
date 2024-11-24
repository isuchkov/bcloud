output "public_ip" {
  value = azurerm_public_ip.vm_public_ip.ip_address
}

output "vm_private_key" {
  value     = tls_private_key.secureadmin_ssh.private_key_pem
  sensitive = true  # Mark as sensitive to avoid accidental exposure
  description = "The private SSH key for the VM."
}