resource "azurerm_service_plan" wsp {
    name = "${var.logic_app_name}-wsp"
    resource_group_name = var.resource_group_name
    location = var.location
    sku_name = "WS1"
    os_type = "Windows"
}

# resource "azurerm_logic_app_standard" la {
#     name = var.logic_app_name
#     resource_group_name = var.resource_group_name
#     location = var.location
#     app_service_plan_id = azurerm_service_plan.wsp.id
#     storage_account_name = var.storage_account_name
#     storage_account_access_key = var.storage_account_key

#     app_settings = {
#       "APP_KIND" = "workflowapp"
#       "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
#       "ServiceBus_Namespace_HostName" = ""
#       "StorageAccount_Name" = ""
#       "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
#       "FUNCTIONS_EXTENSION_VERSION" = "~4"
#       "AzureWebJobsStorage" = var.web_jobs_storage_connection_string
#       "FUNCTIONS_WORKER_RUNTIME" = "dotnet-isolated"
#       "WebJobsFeatureFlags" = "EnableMultiLanguageWorker"
#       "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING " = var.web_jobs_storage_connection_string
#     }

#     identity {
#         type = "UserAssigned"
#         identity_ids = [var.user_assigned_identity_id]
#     }
# }
data "azurerm_resource_group" "rg" {
    name = var.resource_group_name
}

resource azapi_resource "la" {
    type = "Microsoft.Web/sites@2022-09-01"
    name = var.logic_app_name
    parent_id = data.azurerm_resource_group.rg.id
    location = var.location
    body = jsonencode({
        identity = {
            type = "UserAssigned"
            userAssignedIdentities = {
                var.user_assigned_identity_id = {
                }
        }        
        kind = "functionapp,workflowapp"
        properties = {
            serverFarmId: azurerm_service_plan.wsp.id
            keyVaultReferenceIdentity: var.user_assigned_identity_id
            httpsOnly = true
            siteConfig = {
                appSettings = [
                    {
                        name = "APP_KIND"
                        value = "workflowapp"
                    },
                    {
                        name = "ApplicationInsightsAgent_EXTENSION_VERSION"
                        value = "~3"
                    },
                    {
                        name = "ServiceBus_Namespace_HostName"
                        value = ""
                    },
                    {
                        name = "StorageAccount_Name"
                        value = ""
                    },
                    {
                        name = "XDT_MicrosoftApplicationInsights_Mode"
                        value = "recommended"
                    },
                    {
                        name = "FUNCTIONS_EXTENSION_VERSION"
                        value = "~4"
                    },
                    {
                        name = "AzureWebJobsStorage"
                        value = var.web_jobs_storage_connection_string
                    },
                    {
                        name = "FUNCTIONS_WORKER_RUNTIME"
                        value = "dotnet-isolated"
                    },
                    {
                        name = "WebJobsFeatureFlags"
                        value = "EnableMultiLanguageWorker"
                    },
                    {
                        name = "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING"
                        value = var.web_jobs_storage_connection_string
                    }
                ]
            }
        }
    })
}