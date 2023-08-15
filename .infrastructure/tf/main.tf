provider "azurerm" {
    features {}
}

module "mi" {
    source = "./modules/user_assigned_managed_identity"
    location = var.location
    resource_group_name = var.resource_group_name
    identity_name = local.managed_identity_name
}


module "azmon" {
    source = "./modules/azure_monitor"
    location = var.location
    resource_group_name = var.resource_group_name
    log_analytics_workspace_name = local.log_analytics_workspace_name
    application_insights_name = local.application_insights_name
    log_retention_days = var.log_retention_days
}

module "kv" {
    source = "./modules/key_vault"
    location = var.location
    resource_group_name = var.resource_group_name
    key_vault_name = local.key_vault_name
    admin_object_id = var.key_vault_admin_object_id
    logic_app_managed_identity_object_id = module.mi.user_assigned_managed_identity_principal_id
}

module "sa" {
    source = "./modules/storage_account"
    location = var.location
    resource_group_name = var.resource_group_name
    storage_account_name = local.storage_account_name
}

module "saconnstr" {
    source = "./modules/key_vault_secret"
    secret_name = "AzureWebJobsStorageConnectionString"
    key_vault_id = module.kv.id
    secret_value = module.sa.storage_account_primary_connection_string
}

module la {
    source = "./modules/logic_app"
    location = var.location
    resource_group_name = var.resource_group_name
    logic_app_name = local.logic_app_name
    storage_account_name = module.sa.storage_account_name
    managed_identity_name = local.managed_identity_name
    storage_account_key = module.sa.storage_account_primary_connection_string
    user_assigned_identity_id = module.mi.id
    web_jobs_storage_connection_string = "@Microsoft.KeyVault(SecretUri={module.saconnstr.secret_uri})"
}