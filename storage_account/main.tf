resource "azurerm_storage_account" "sg" {
  name                              = var.name
  resource_group_name               = var.resource_group
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  #enable_advanced_threat_protection = "true"
  tags                              = var.tags
}
