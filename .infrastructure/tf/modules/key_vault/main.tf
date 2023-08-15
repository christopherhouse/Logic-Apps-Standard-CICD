data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
    name = var.key_vault_name
    resource_group_name = var.resource_group_name
    location = var.location
    tenant_id = data.azurerm_client_config.current.tenant_id
    sku_name = "standard"
    
    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = var.admin_object_id

        key_permissions = [
            "Backup", 
            "Create",
            "Decrypt",
            "Delete",
            "Encrypt",
            "Get",
            "Import",
            "List",
            "Purge",
            "Recover",
            "Restore",
            "Sign",
            "UnwrapKey",
            "Update",
            "Verify",
            "WrapKey",
            "Release",
            "Rotate",
            "GetRotationPolicy",
            "SetRotationPolicy"
            ]
        secret_permissions = [
            "Backup",
            "Delete",
            "Get",
            "List",
            "Purge",
            "Recover",
            "Restore",
            "Set"
            ]
        certificate_permissions = [
            "Backup",
            "Create",
            "Delete",
            "DeleteIssuers",
            "Get",
            "GetIssuers",
            "Import",
            "List",
            "ListIssuers",
            "ManageContacts",
            "ManageIssuers",
            "Purge",
            "Recover",
            "Restore",
            "SetIssuers",
            "Update"
            ]
    }

    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = var.logic_app_managed_identity_object_id

        secret_permissions = [
            "Get", "List"]
        certificate_permissions = ["Get", "List"]
    }
}