output "vm_public_ip" {
  value = module.vm.public_ip
}

output "vm_private_key_from_module" {
  value     = module.vm.vm_private_key
  sensitive = true  # Ensure sensitive handling in Terraform CLI output
  description = "The private key output from the VM module."
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "acr_name" {
  value = module.acr.name
}
