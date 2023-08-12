param keyVaultName string
param appInsightsName string
param storageAccountName string

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: keyVaultName
  scope: resourceGroup()
}


resource ai 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
  scope: resourceGroup()
}

resource sa 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
  scope: resourceGroup()
}

resource iKey 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: 'APPINSIGHTS-INSTRUMENTATIONKEY'
  parent: kv
  properties: {
    value: ai.properties.InstrumentationKey
  }
}

resource aiCs 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: 'APPINSIGHTS-CONNECTIONSTRING'
  parent: kv
  properties: {
    value: ai.properties.ConnectionString
  }
}

resource sca 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: 'STORAGEACCOUNT-CONNECTIONSTRING'
  parent: kv
  properties: {
    value: 'DefaultEndpointsProtocol=https;AccountName=${sa.name};AccountKey=${sa.listKeys().keys[0].value};EndpointSuffix=core.windows.net'
  }
}

output appInsightsInstrumentationKeySecretUri string = iKey.properties.secretUri
output appInsightsConnectionStringSecretUri string = aiCs.properties.secretUri
output storageAccountConnectionStringSecretUri string = sca.properties.secretUri

