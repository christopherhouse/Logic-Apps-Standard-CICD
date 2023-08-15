variable "key_vault_name" {
    type = string
    description = "Name of the key vault to be created"
}

variable "resource_group_name" {
    type = string
    description = "Name of the resource group the Key Vault will be created in"
}

variable "location" {
    type = string
    description = "The Azure region where the Key Vault will be created"
}

variable "admin_object_id" {
    type = string
    description = "The object ID of the user or service principal that will be granted admin access to the Key Vault"
}

variable logic_app_managed_identity_object_id {
    type = string
    description = "The object ID of the managed identity that will be granted access to the Key Vault"
}