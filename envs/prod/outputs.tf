output "resource_group_name" { value = azurerm_resource_group.this.name }
output "aks_name" { value = module.aks.name }
output "acr_login_server" { value = module.registry.login_server }
output "key_vault_uri" { value = module.keyvault.vault_uri }
output "postgres_fqdn" { value = module.postgresql.fqdn }
