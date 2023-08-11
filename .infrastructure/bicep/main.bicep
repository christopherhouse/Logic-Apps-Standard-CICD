param workloadName string
param environmentName string
param resourceNamePrefix string

var baseResourceName = '${resourceNamePrefix}-${workloadName}-${environmentName}-'
var baseResourceNameLowerNoDashes = '${toLower(resourceNamePrefix)}${toLower(workloadName)}${toLower(environmentName)}'
