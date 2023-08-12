param managedIdentityName string
param location string

resource uami 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

output id string = uami.id
output principalId string = uami.properties.clientId
output clientId string = uami.properties.clientId
output name string = uami.name
