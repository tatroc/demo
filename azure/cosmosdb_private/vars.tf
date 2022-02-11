variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  default     = "northcentralus"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created."
  type        = string
}

variable "name" {
  description = "Specifies the name of the CosmosDB Account and related resources. Changing this forces a new resource to be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
  type        = string
}

variable "enable_automatic_failover" {
  description = "Enable automatic fail over for this Cosmos DB account."
  type        = string
  default     = false
}

variable "is_virtual_network_filter_enabled" {
  description = "Enables virtual network filtering for this Cosmos DB account."
  type        = string
  default     = true
}

variable "virtual_network_rule_ids" {
  description = "Specifies a virtual_network_rules resource, used to define which subnets are allowed to access this CosmosDB account."
  type        = list
  default     = []
}

variable "ip_range_filter" {
  description = "CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. IP addresses/ranges must be comma separated and must not contain any spaces."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all associated resources."
  type        = map(string)
  default     = {}
}

variable "access_key_metadata_writes_enabled" {
  description = "Is write operations on metadata resources (databases, containers, throughput) via account keys enabled"
  type        = bool
  default     = false
}
