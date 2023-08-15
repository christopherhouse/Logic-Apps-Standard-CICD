variable "secret_name" {
    type = string
    description = "Name of the secret to create"
}

variable "key_vault_id" {
    type = string
    description = "Resource id of the Key Vault that will contain the secret"
}

variable "secret_value" {
    type = string
    description = "Value of the secret"
    sensitive = true
}
