resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

#Search for warnings in tf apply
module "aks" {
  source              = "./modules/aks/azurerm-aks"
  resource_group_name = azurerm_resource_group.example.name
  client_id           = var.client_id
  client_secret       = var.client_secret
  prefix              = "az"
}
