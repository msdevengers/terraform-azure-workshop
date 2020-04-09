data "azurerm_resource_group" "simple-rg" {
  name = "pamir-poc-tf-rg"
}

output "poc-rg-id" {
  value = data.azurerm_resource_group.simple-rg.id
}
output "poc-rg-location" {
  value = data.azurerm_resource_group.simple-rg.location
}