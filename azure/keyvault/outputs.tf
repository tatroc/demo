output "resource_group_name" {
  value = azurerm_resource_group.vault.name
}

output "keyvault_name" {
  value = azurerm_key_vault.vault.name
}

output "keyvault_id" {
  value = azurerm_key_vault.vault.id
}
