# Azure CosmosDB with Private Endpoint
version
This module will create an Azure CosmosDB Account and a Private Endpoint Connection. It will configure the CosmosDB Account to only allow traffic from specified network IP Address ranges, and will also configure the Private Endpoint Connection to provide an internal IP address in the specified subnet.

## Usage
```hcl
module "example" {
  source = "git::ssh://git@kss-github.kaplan.com/Kaplan/tssdevops.azure.terraform//cosmosdb_private"

  # Required Inputs
  name                = "cosmos-dev-example-northcentralus"
  resource_group_name = "rg-dev-example-northcentralus"
  subnet_id           = "/subscriptions/8701016c-7d8e-4940-993c-fda1a8417f46/resourceGroups/usnc-rg-s02-vnet-cosmosdb/providers/Microsoft.Network/virtualNetworks/usnc-vnet-s02-cosmosdb/subnets/usnc-snet-s02-cosmosdb-test"

  # Optional Inputs (default values are provided)
  location                          = "northcentralus"
  enable_automatic_failover         = false
  is_virtual_network_filter_enabled = true
  virtual_network_rule_ids          = []
  ip_range_filter                   = null
  tags = {
    "REPOSITORY_URL"    = ""
    "AUTHOR"            = ""
    "CONTACT"           = "tss-devops@kaplan.com"
    "ENVIRONMENT"       = "dev"
    "PROJECT_NAME"      = "example"
    "PROVIDER_VERSION"  = "v2.51.0"
    "TERRAFORM_VERSION" = "0.12.29"
    "WORKSPACE_NAME"    = "dev-example-northcentralus"
  }
}
```
