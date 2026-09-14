variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "address_space" { type = list(string) }
variable "aks_subnet_cidr" { type = string }
variable "data_subnet_cidr" { type = string }
variable "tags" { type = map(string) }
