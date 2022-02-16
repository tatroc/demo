# My comment 27
locals {

  tags            = merge(var.tags, {"PROVISIONED_BY" = "KNA CloudOps Terraform 2", "CONTACT" = "devops@domain.com", "OWNER" = "christopher.tatro@kaplan.edu", "VERSION" = "v145"})
  subnet_id       = var.subnet_id
  subscription_id = "8701016c-7d8e-4940-993c-fda1a8417f46"
  ip_range_filter = var.ip_range_filter == null ? "104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26,0.0.0.0" : trimspace(join(",", ["104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26,0.0.0.0", var.ip_range_filter]))
}

data "terraform_remote_state" "network" {
  backend = "azurerm"
  workspace = "networking"

  config = {
    resource_group_name  = "rg-s02-terraform"
    storage_account_name = "terraformology"
    container_name       = "s02-terraform"
    key                  = "s02.tfstate"
    subscription_id      = local.subscription_id
    tenant_id            = "f895a74b-e96c-4af4-be16-fe5308979167"
  }
}

resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                                = var.name
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  offer_type                          = "Standard"
  kind                                = "GlobalDocumentDB"
  enable_automatic_failover           = var.enable_automatic_failover
  is_virtual_network_filter_enabled   = var.is_virtual_network_filter_enabled
  ip_range_filter                     = local.ip_range_filter
  tags                                = local.tags
  access_key_metadata_writes_enabled  = var.access_key_metadata_writes_enabled

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    prefix            = format("gl-%s", var.name)
    location          = var.location
    failover_priority = 0
  }

  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rule_ids
    content {
      id = virtual_network_rule.value
    }
  }
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = format("pep-%s", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.subnet_id

  private_service_connection {
    name                           = format("psc-%s", var.name)
    private_connection_resource_id = azurerm_cosmosdb_account.cosmosdb_account.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }
}
