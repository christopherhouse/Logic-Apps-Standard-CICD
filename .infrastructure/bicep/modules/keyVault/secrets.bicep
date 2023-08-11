param keyVaultName string
param appInsightsName string

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: keyVaultName
  scope: resourceGroup()
}

resource ai 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
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

output appInsightsInstrumentationKeySecretUri string = iKey.properties.secretUri
output appInsightsConnectionStringSecretUri string = aiCs.properties.secretUri
