variable "subscription_id" {
  type        = string
  description = "Azure subscription ID used by the provider."
}

variable "location" {
  type        = string
  description = "Azure region for the lab."
  default     = "westeurope"
}

variable "project" {
  type        = string
  description = "Short project name used in resource naming."
  default     = "emir32cloud"
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "dev"
}

variable "postgres_admin_password" {
  type        = string
  description = "Demo PostgreSQL administrator password. Never commit the real value."
  sensitive   = true
}
