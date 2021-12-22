variable "rg_name" {
  default = null
}

variable "location" {
}

variable "kv_name" {
}

variable "sku" {
  default = "standard"
}

variable "object_id" {
}

variable "key_permissions" {
  type = list(string)
}

variable "secret_permissions" {
  type = list(string)
}

variable "certificate_permissions" {
  type = list(string)
}

variable "default_action" {
  default = "Deny"
}

variable "bypass_rule" {
}

variable "ip_rules" {
  type = list(string)
}
