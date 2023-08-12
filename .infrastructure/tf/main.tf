provider "azurerm" {
    features {}
}

module "azmon" {
    source = "./modules/azure_monitor"
    location = var.location
    resource_group_name = var.resource_group_name
    log_analytics_workspace_name = local.log_analytics_workspace_name
    application_insights_name = local.application_insights_name
    log_retention_days = var.log_retention_days
}