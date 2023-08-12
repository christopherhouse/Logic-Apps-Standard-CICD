resource "azurerm_log_analytics_workspace" "laws" {
    name = var.log_analytics_workspace_name
    resource_group_name = var.resource_group_name
    location = var.location
    sku = "PerGB2018"
    retention_in_days = var.log_retention_days
}

resource "azurerm_application_insights" "ai" {
    name = var.application_insights_name
    location = var.location
    resource_group_name = var.resource_group_name
    workspace_id = azurerm_log_analytics_workspace.laws.id
    application_type = "web"
    retention_in_days = var.log_retention_days
}
