using '../main.bicep'
param workloadName = 'la-cicd'
param environmentName = 'dev'
param resourceNamePrefix = 'cmh'
param location = 'eastus'
param adminUserObjectIds = [
  'c9be89aa-0783-4310-b73a-f81f4c3f5407'
]
