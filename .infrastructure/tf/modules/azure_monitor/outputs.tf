output "log_analytics_workspace_id" {
    value = azurerm_log_analytics_workspace.laws.id
}

output "log_analytics_workspace_name" {
    value = azurerm_log_analytics_workspace.laws.name
}

output "app_insights_instrumentation_key" {
    value = azurerm_application_insights.ai.instrumentation_key
    sensitive = true
}

output "app_insights_connection_string" {
    value = azurerm_application_insights.ai.connection_string
    sensitive = true
}
