# tssdevops.azure.keyvault
Terraform 12 module which creates an Azure Storage Account
version
These types of resources are supported:
* [Resource Group](https://www.terraform.io/docs/providers/azurerm/d/resource_group.html)


## Usage

```hcl
module "storage_account" {
  source                  = "git::https://github.com/tatroc/demo/releases/download/storage_account-0.1.88/storage_account-0.1.88-tf-module.zip"
  location                = "northcentralus"
  name                 = "devopsstorageaccount"
  account_tier                     = "Standard"
  account_replication_type               = "LRS"
  tags                                = {}
}
```

## Resource Group
By default this module will create the Resource group (rg_name) using the KHE naming convention for Azure Resource Groups. It will use the following format to construct the name:
* "rg-<terraform.workspace>"
