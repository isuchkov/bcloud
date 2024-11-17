resource "azurerm_key_vault" "vault" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = "bd4f0481-b137-40f1-9e64-20cfd55fbf49"
  sku_name            = "standard"
}
