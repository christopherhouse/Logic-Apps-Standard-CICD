variable "workload_name" {
    type = string
}

variable "environment_name" {
    type = string
}

variable "resource_name_prefix" {
    type = string
}

variable "location" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "log_retention_days" {
    type = number
    default = 90
}

variable "key_vault_admin_object_id" {
    type = string
}