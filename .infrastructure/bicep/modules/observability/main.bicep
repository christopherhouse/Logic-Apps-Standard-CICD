param logAnalayticsWorkspaceName string
param appInsightsName string
param location string

resource laws 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalayticsWorkspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource ai 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Bluefield'
    WorkspaceResourceId: laws.id
    RetentionInDays: 30
  }
}

output logAnalyticsId string = laws.id
output appInsightsId string = ai.id
output logAnalyticsName string = laws.name
output appInsightsName string = ai.name
