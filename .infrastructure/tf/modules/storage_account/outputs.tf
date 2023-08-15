output "id" {
    value = azurerm_storage_account.storage.id
    description = "The resource id of the storage account."

}

output "storage_account_name" {
    value = azurerm_storage_account.storage.name
}

output "storage_account_primary_access_key" {
    value = azurerm_storage_account.storage.primary_access_key
    sensitive = true
}