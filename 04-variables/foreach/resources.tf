locals {
  resource_groups = {
      rg1 = "pamir-rg"
      rg2 = "mehmet-rg"
      rg3 = "hakki-rg"
      rg4 = "osman-rg"
      rg5 = "alwaysp-rg"
  }
}


resource "azurerm_resource_group" "pamir-rg" {
    for_each = local.resource_groups
    name = "${each.value}"
    location = "westeurope"
}