variable "name" {
  type = string
}

variable "resource_group" {
  type = string
}


# https://www.terraform.io/docs/providers/azurerm/r/storage_account.html#account_tier
# https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-performance-tiers
variable "account_tier" {
  default = "Standard"
  type    = string
}

# https://www.terraform.io/docs/providers/azurerm/r/storage_account.html#account_replication_type
# https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
variable "account_replication_type" {
  default = "LRS"
  type    = string
}

variable "location" {
  default = "northcentralus"
}

variable "tags" {
  type = map(string)
}
