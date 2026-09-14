locals {
  name_prefix = "${var.project}-${var.environment}"
  compact     = replace(local.name_prefix, "-", "")

  tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
    repository  = "azure-enterprise-platform"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

module "network" {
  source              = "../../modules/network"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.30.0.0/16"]
  aks_subnet_cidr     = "10.30.0.0/20"
  data_subnet_cidr    = "10.30.16.0/24"
  tags                = local.tags
}

module "observability" {
  source              = "../../modules/observability"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  retention_in_days   = 90
  tags                = local.tags
}

module "registry" {
  source              = "../../modules/registry"
  registry_name       = substr("${local.compact}acr", 0, 50)
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  sku                 = "Premium"
  tags                = local.tags
}

module "keyvault" {
  source                   = "../../modules/keyvault"
  key_vault_name           = substr("${local.compact}kv", 0, 24)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.this.name
  purge_protection_enabled = true
  tags                     = local.tags
}

module "aks" {
  source                     = "../../modules/aks"
  name_prefix                = local.name_prefix
  location                   = var.location
  resource_group_name        = azurerm_resource_group.this.name
  subnet_id                  = module.network.aks_subnet_id
  acr_id                     = module.registry.id
  log_analytics_workspace_id = module.observability.workspace_id
  node_vm_size               = "Standard_D2s_v5"
  node_count                 = 3
  tags                       = local.tags
}

module "postgresql" {
  source                 = "../../modules/postgresql"
  name_prefix            = local.name_prefix
  location               = var.location
  resource_group_name    = azurerm_resource_group.this.name
  vnet_id                = module.network.vnet_id
  delegated_subnet_id    = module.network.data_subnet_id
  private_dns_zone_name  = "${local.name_prefix}.postgres.database.azure.com"
  administrator_login    = "pgadminuser"
  administrator_password = var.postgres_admin_password
  sku_name               = "GP_Standard_D2s_v3"
  storage_mb             = 65536
  backup_retention_days  = 14
  zone                    = "1"
  tags                    = local.tags
}
