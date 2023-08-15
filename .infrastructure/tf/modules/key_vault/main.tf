data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
    name = var.key_vault_name
    resource_group_name = var.resource_group_name
    location = var.location
    tenant_id = data.azurerm_client_config.current.tenant_id
    sku_name = "standard"
    enable_rbac_authorization = true
}

# Copilot prompt:
# Create an rbac assignment for each principal ID in a list variable name admin_object_ids.
# The role assignment is scoped to the key vault resource created above and should grant the
# KeyVaultAdministrator role to each principal ID in the list.
resource "azurerm_role_assignment" "kv_admin" {
    for_each = toset(var.admin_object_ids)
    scope = azurerm_key_vault.kv.id
    role_definition_name = "Key Vault Administrator"
    principal_id = each.value
}

resource "azurerm_role_assignment" kv_la {
    scope = azurerm_key_vault.kv.id
    role_definition_name = "Key Vault Secrets User"
    principal_id = var.logic_app_managed_identity_object_id
}