variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "vnet_id" { type = string }
variable "delegated_subnet_id" { type = string }
variable "private_dns_zone_name" { type = string }
variable "administrator_login" { type = string }

variable "administrator_password" {
  type      = string
  sensitive = true
}

variable "sku_name" { type = string }
variable "storage_mb" { type = number }
variable "backup_retention_days" { type = number }
variable "zone" { type = string }
variable "tags" { type = map(string) }
