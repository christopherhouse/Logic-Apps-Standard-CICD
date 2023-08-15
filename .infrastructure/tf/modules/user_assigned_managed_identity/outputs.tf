output "user_assigned_managed_identity_principal_id" {
    value = azurerm_user_assigned_identity.umami.principal_id
}

output "id" {
    value = azurerm_user_assigned_identity.umami.id
}

output "client_id" {
    value = azurerm_user_assigned_identity.umami.client_id
}
