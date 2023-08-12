param serivceBusNamespaceName string
param topicName string
param subscriptionname string
param location string

resource sb 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: serivceBusNamespaceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
}

resource tp 'Microsoft.ServiceBus/namespaces/topics@2022-10-01-preview' = {
  parent: sb
  name: topicName
  properties: {
  }
}

resource sub 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-10-01-preview' = {
  parent: tp
  name: subscriptionname
  properties: {
  }
}

resource flt 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2022-10-01-preview' = {
  name: 'all-message'
  parent: sub
  properties: {
    filterType: 'SqlFilter'
    sqlFilter: {
      sqlExpression: '1=1'
      requiresPreprocessing: false
    }
  }
}

output id string = sb.id
output name string = sb.name
