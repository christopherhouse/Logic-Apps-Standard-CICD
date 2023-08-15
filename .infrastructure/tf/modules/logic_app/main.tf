resource "azurerm_service_plan" wsp {
    name = "${var.logic_app_name}-wsp"
    resource_group_name = var.resource_group_name
    location = var.location
    sku_name = "WS1"
    os_type = "Windows"
}

resource "azurerm_logic_app_standard" la {
    name = var.logic_app_name
    resource_group_name = var.resource_group_name
    location = var.location
    app_service_plan_id = azurerm_service_plan.wsp.id
    storage_account_name = var.storage_account_name
    storage_account_access_key = var.storage_account_key

    app_settings = {

    }

    identity {
        type = "UserAssigned"
        identity_ids = [var.user_assigned_identity_id]
    }
}