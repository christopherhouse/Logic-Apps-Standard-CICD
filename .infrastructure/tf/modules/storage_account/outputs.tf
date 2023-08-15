output "id" {
    value = azurerm_storage_account.storage.id
    description = "The resource id of the storage account."

}

output "primary_web_hostname" {
    value = replace(replace(azurerm_storage_account.storage.primary_web_endpoint, "https://", ""), "/", "")
    description = "The primary web endpoint of the storage account."
}

output "secondary_web_hostname" {
    value = replace(replace(azurerm_storage_account.storage.secondary_web_endpoint, "https://", ""), "/", "")
    description = "The secondary web endpoint of the storage account."
}
