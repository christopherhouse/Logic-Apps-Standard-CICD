variable "resource_group_name" {
    type = string
    description = "The name of the resource group in which to create the resources"
}

variable "location" {
    type = string
    description = "The Azure region in which to create the resources"
}

variable log_analytics_workspace_name {
    type = string
    description = "The name of the log analytics workspace to create"
}

variable "application_insights_name" {
    type = string
    description = "The name of the application insights instance to create"
}

variable "log_retention_days" {
    type = number
    description = "The number of days to retain logs in the log analytics workspace"
}
