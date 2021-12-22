locals {
  rg_name = var.rg_name == null ? format("rg-%s-%s", var.kv_name, terraform.workspace) : var.rg_name
}

resource "azurerm_resource_group" "vault" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_key_vault" "vault" {
  name                            = format("kv-%s-%s", var.kv_name, terraform.workspace)
  location                        = var.location
  resource_group_name             = azurerm_resource_group.vault.name
  tenant_id                       = "f895a74b-e96c-4af4-be16-fe5308979167"
  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  soft_delete_enabled             = true
  sku_name                        = var.sku
  
  access_policy {
    tenant_id               = "f895a74b-e96c-4af4-be16-fe5308979167"
    object_id               = var.object_id
    key_permissions         = var.key_permissions
    secret_permissions      = var.secret_permissions
    certificate_permissions = var.certificate_permissions
  }
  network_acls {
    default_action = var.default_action
    bypass         = var.bypass_rule
    ip_rules       = var.ip_rules
  }
  tags = {
    environment = format("%s", substr(terraform.workspace, 0, 3))
  }
  
  lifecycle {
    ignore_changes = [
      access_policy
    ]
  }
}
