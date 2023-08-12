param logicAppName string
param workflowServicePlanName string
param location string
param storageAccountName string
param userAssignedIdentityObjectId string
param appInsightsInstrumentationKeySecretUri string
param appInsightsConnectionStringSecretUri string
param storageConnectionStringSecretUri string
param serviceBusNamespaceName string
param logAnalyticsWorkspaceId string

resource wsp 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: workflowServicePlanName
  location: location
  sku: {
    name: 'WS1'
  }
  properties: {
  }
}

resource la 'Microsoft.Web/sites@2022-09-01' = {
  name: logicAppName
  location: location
  kind: 'functionapp,workflowapp'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityObjectId}': {}
    }
  }
  properties: {
    serverFarmId: wsp.id
    keyVaultReferenceIdentity: userAssignedIdentityObjectId
    httpsOnly: true
    siteConfig: {
      netFrameworkVersion: 'v4.8'
      appSettings: [
        {
          name: 'APP_KIND'
          value: 'workflowapp'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: '@Microsoft.KeyVault(SecretUri=${appInsightsInstrumentationKeySecretUri})'
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: '@Microsoft.KeyVault(SecretUri=${appInsightsConnectionStringSecretUri})'
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'ServiceBus_Namespace_HostName'
          value: '${serviceBusNamespaceName}.servicebus.windows.net'
        }
        {
          name: 'StorageAccount_Name'
          value: storageAccountName
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'recommended'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'AzureWebJobsStorage'
          value: '@Microsoft.KeyVault(SecretUri=${storageConnectionStringSecretUri})'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet-isolated'
        }
        {
          name: 'WebJobsFeatureFlags'
          value: 'EnableMultiLanguageWorker'
        }
      ]
    }
  }
}

resource diags 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'laws'
  scope: la
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'WorkflowRuntime'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

output logicAppId string = la.id
output logicAppName string = la.name
