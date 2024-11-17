output "vm_public_ip" {
  value = module.vm.public_ip
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
