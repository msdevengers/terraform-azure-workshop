locals {
  resource_group_name = "${var.resource_group_name}-${var.resource_group_name_postfix}"
}

resource "azurerm_resource_group" "pamir-rg" {
  name     = local.resource_group_name
  location = var.location_list[0]
}