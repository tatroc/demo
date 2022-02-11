# CosmosDB Outputs
output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.cosmosdb_account.id
}

output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.cosmosdb_account.name
}

output "cosmosdb_account_endpoint" {
  value = azurerm_cosmosdb_account.cosmosdb_account.endpoint
}

output "cosmosdb_account_primary_key" {
  value = azurerm_cosmosdb_account.cosmosdb_account.primary_key
}

output "cosmosdb_account_primary_readonly_key" {
  value = azurerm_cosmosdb_account.cosmosdb_account.primary_readonly_key
}

output "cosmosdb_account_connection_strings" {
  value = azurerm_cosmosdb_account.cosmosdb_account.connection_strings
}

# Private Endpoint Connection Outputs
output "private_endpoint_id" {
  value = azurerm_private_endpoint.private_endpoint.id
}

output "private_endpoint_primary_ip" {
  value = azurerm_private_endpoint.private_endpoint.custom_dns_configs.0.ip_addresses.0
}

output "private_endpoint_secondary_ip" {
  value = azurerm_private_endpoint.private_endpoint.custom_dns_configs.1.ip_addresses.0
}