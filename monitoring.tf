resource "azurerm_log_analytics_workspace" "aks" {
  name                = "recipe-logs-workspace"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Velero backup storage
resource "azurerm_storage_account" "velero" {
  name                     = "recipevelero${substr(md5(azurerm_resource_group.main.id), 0, 6)}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "velero" {
  name                  = "velero-backups"
  storage_account_name  = azurerm_storage_account.velero.name
  container_access_type = "private"
}

output "velero_storage_account" {
  value = azurerm_storage_account.velero.name
}

output "velero_storage_key" {
  value     = azurerm_storage_account.velero.primary_access_key
  sensitive = true
}
