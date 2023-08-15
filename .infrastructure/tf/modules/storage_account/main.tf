resource "azurerm_storage_account" "storage" {
    name = var.storage_account_name
    resource_group_name = var.resource_group_name
    location = var.location
    account_kind = "StorageV2"
    account_tier = "Standard"
    account_replication_type = var.storage_sku
    enable_https_traffic_only = true

    static_website {
        index_document = "index.html"
        error_404_document = "404/index.html"
    }
}

resource "azurerm_storage_account_network_rules" "block_public" {
    storage_account_id = azurerm_storage_account.storage.id
    default_action = "Deny"
    bypass = ["None"]
    ip_rules = [var.home_ip_address]
}
