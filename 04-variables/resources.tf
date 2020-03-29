resource "azurerm_resource_group" "pamir-rg" {
  name     = var.resource_group_name
  location = var.location_list[0]
}