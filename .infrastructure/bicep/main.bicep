param workloadName string
param environmentName string
param resourceNamePrefix string
param location string
param buildId string = utcNow()
param adminUserObjectIds array = []

var baseResourceName = '${resourceNamePrefix}-${workloadName}-${environmentName}'
var baseNameLowerNoDashes = toLower(replace(baseResourceName, '-', ''))
var baseResourceShortName = length(baseNameLowerNoDashes) > 22 ? substring(baseNameLowerNoDashes, 0, 22) : baseNameLowerNoDashes

var storageAccountName = '${baseResourceShortName}sa'
var userAssignedManagedIdentityName = '${baseResourceName}-uami'
var keyVaultName = '${baseResourceName}-kv'
var logAnalyticsWorkspaceName = '${baseResourceName}-laws'
var appInsightsName = '${baseResourceName}-ai'
var logicAppName = '${baseResourceName}-la'
var workflowServicePlanName = '${baseResourceName}-wsp'

module logicAppStorage './modules/storageAccount/main.bicep' = {
  name: '${storageAccountName}-${buildId}'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

module mi './modules/userAssignedManagedIdentity/main.bicep' = {
  name: '${userAssignedManagedIdentityName}-${buildId}'
  params: {
    managedIdentityName: userAssignedManagedIdentityName
    location: location
  }
}

module keyVault './modules/keyVault/main.bicep' = {
  name: '${keyVaultName}-${buildId}'
  params: {
    keyVaultName: keyVaultName
    location: location
    applicationUserObjectIds: [ mi.outputs.principalId ]
    adminUserObjectIds: adminUserObjectIds
  }
}

module logs './modules/observability/main.bicep' = {
  name: '${logAnalyticsWorkspaceName}-${buildId}'
  params: {
    appInsightsName: appInsightsName
    logAnalayticsWorkspaceName: logAnalyticsWorkspaceName
    location: location
  }
}

module secrets './modules/keyVault/secrets.bicep' = {
  name: 'secrets-${buildId}'
  params: {
    appInsightsName: logs.outputs.appInsightsName
    keyVaultName: keyVault.outputs.name
    storageAccountName: logicAppStorage.outputs.name
  }
}

module la './modules/logicApp/main.bicep' = {
  name: '${logicAppName}-${buildId}'
  params: {
    location: location
    appInsightsConnectionStringSecretUri: secrets.outputs.appInsightsConnectionStringSecretUri
    appInsightsInstrumentationKeySecretUri: secrets.outputs.appInsightsInstrumentationKeySecretUri 
    logAnalyticsWorkspaceId: logs.outputs.logAnalyticsId
    logicAppName: logicAppName
    serviceBusNamespaceName: 'tbd'
    storageAccountName: logicAppStorage.outputs.name
    storageConnectionStringSecretUri: secrets.outputs.storageAccountConnectionStringSecretUri
    userAssignedIdentityObjectId: mi.outputs.id
    workflowServicePlanName: workflowServicePlanName
  }
}
