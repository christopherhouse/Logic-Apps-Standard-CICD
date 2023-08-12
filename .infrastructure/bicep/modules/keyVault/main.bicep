param keyVaultName string
param location string
param adminUserObjectIds array
param applicationUserObjectIds array

var adminPolicies = [for admin in adminUserObjectIds: {
  tenantId: subscription().tenantId
  objectId: admin
  permissions: {
    keys: ['all']
    secrets: ['all']
    certificates: ['all']
  }
}]

var appPolicies = [for app in applicationUserObjectIds: {
  tenantId: subscription().tenantId
  objectId: app
  permissions: {
    secrets: ['Get', 'List']
  }
}]

var policies = union(adminPolicies, appPolicies)

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    accessPolicies: policies
    enabledForDeployment: false
    enabledForTemplateDeployment: false
    enabledForDiskEncryption: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
  }
}

output id string = keyVault.id
output name string = keyVault.name
