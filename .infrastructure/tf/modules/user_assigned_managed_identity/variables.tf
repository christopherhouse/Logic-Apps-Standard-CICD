variable "identity_name" {
    type = string
    description = "The name of the User Assigned Managed Identity to create"
}

variable "resource_group_name" {
    type = string
    description = "The name of the Resource Group in which to create the User Assigned Managed Identity"
}

variable "location" {
    type = string
    description = "The Azure Region in which to create the User Assigned Managed Identity"
}
