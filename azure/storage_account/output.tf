output "name" {
  value = azurerm_storage_account.sg.name
}

output "id" {
  value = azurerm_storage_account.sg.id
}

output "access_key" {
  value = azurerm_storage_account.sg.primary_access_key
}

output "connection_string" {
  value = azurerm_storage_account.sg.primary_connection_string
}