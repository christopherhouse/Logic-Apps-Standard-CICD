param storageAccountName string
param location string

// Copilot promot:
// Create an Azure Storage Account using the storageName and location parameters above to define the resource name
// and deployment region.  The storage account should use the Hot access tier and the Standard_LRS sku
resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

output id string = storage.id
output name string = storage.name
