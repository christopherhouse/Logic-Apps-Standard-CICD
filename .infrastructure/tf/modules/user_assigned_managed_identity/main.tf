resource "azurerm_user_assigned_identity" "umami" {
  name = var.identity_name
  resource_group_name = var.resource_group_name
  location = var.location
}
