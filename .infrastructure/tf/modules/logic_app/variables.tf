variable "logic_app_name" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
}

variable "storage_account_name" {
    type = string
}

variable "managed_identity_name" {
    type = string
}

variable "storage_account_key" {
    type = string
    sensitive = true
}

variable "user_assigned_identity_id" {
    type = string
}

variable "web_jobs_storage_connection_string" {
    type = string
    sensitive = true
}