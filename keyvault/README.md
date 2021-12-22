# tssdevops.azure.keyvault
Terraform 12 module which creates an Azure Key Vault

These types of resources are supported:
* [Resource Group](https://www.terraform.io/docs/providers/azurerm/d/resource_group.html)
* [Azure Key Vault](https://www.terraform.io/docs/providers/azurerm/r/key_vault.html)

## Usage

```hcl
module "devops-keyvault" {
  source                  = "git::ssh://git@kss-github.kaplan.com/tssdevops/terraform.modules//keyvault"
  location                = "northcentralus"
  kv_name                 = "devopskeyvault"
  sku                     = "premium"
  object_id               = "720a8e99-a30a-4564-851d-65724e6f9431"
  key_permissions         = ["Get", "List", "Decrypt", "Update", "Encrypt"]
  secret_permissions      = ["Get", "list", "Set", "Delete"]
  certificate_permissions = ["Get", "List"]
  default_action          = "Deny"
  bypass_rule             = "AzureServices"
  ip_rules                = ["172.22.0.0/16"]
}
```

## Resource Group
By default this module will create the Resource group (rg_name) using the KHE naming convention for Azure Resource Groups. It will use the following format to construct the name:
* "rg-<terraform.workspace>"
