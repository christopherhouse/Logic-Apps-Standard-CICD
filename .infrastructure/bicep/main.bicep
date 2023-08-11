param workloadName string
param environmentName string
param resourceNamePrefix string
param location string
param buildId string = utcNow()
param adminUserObjectIds array = []

var baseResourceName = '${resourceNamePrefix}-${workloadName}-${environmentName}'
var baseNameLowerNoDashes = toLower(replace(toLower(baseResourceName), '-', ''))
var baseResourceShortName = length(baseNameLowerNoDashes) > 22 ? substring(baseNameLowerNoDashes, 0, 22) : baseNameLowerNoDashes

var storageAccountName = '${baseResourceShortName}sa'
var userAssignedManagedIdentityName = '${baseResourceShortName}-uami'
var keyVaultName = '${baseResourceShortName}-kv'
var logAnalyticsWorkspaceName = '${baseResourceShortName}-laws'
var appInsightsName = '${baseResourceShortName}-ai'

module logicAppStorage './modules/storageAccount/main.bicep' = {
  name: '${storageAccountName}-${buildId}'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

module managedId './modules/userAssignedManagedIdentity/main.bicep' = {
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
    applicationUserObjectIds: []
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
  }
}
