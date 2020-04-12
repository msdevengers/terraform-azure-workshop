resource "azurerm_resource_group" "pamir-rg" {
    count = 5
    name = "pamir-rg${count.index}"
    location = "westeurope"
}