variable "storage_account_name" {
    type = string
    description = "Name of the storage account"
}

variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "location" {
    type = string
    description = "Azure region where the API Management resource should be created"
}

variable "storage_sku" {
    type = string
    description = "SKU of the storage account"
    default = "GRS"

    validation {
        condition = contains(["LRS", "GRS", "RAGRS", "ZRS"], var.storage_sku)
        error_message = "Invalid storage SKU"
    }
}

variable "home_ip_address" {
    type = string
    description = "IP address of the home network"
}