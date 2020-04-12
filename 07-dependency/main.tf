resource "azurerm_resource_group" "elk_rg" {
    name = format("%s%s","elk", var.resource_group_postfix)
    location = var.location
    tags = var.elk_tags
}
resource "azurerm_virtual_network" "elk_vnet" {
    name = format("%s%s","elk", var.vnet_postfix)
    location = azurerm_resource_group.elk_rg.location
    resource_group_name = azurerm_resource_group.elk_rg.name
    address_space = var.elk_address_space
    subnet {
        name = var.elk_vm_subnet.name
        address_prefix = var.elk_vm_subnet.address_prefix
    }
    tags = azurerm_resource_group.elk_rg.tags
}

resource "azurerm_network_ddos_protection_plan" "ddos_proction" {
    name =  format("%s%s%s%s",var.environment,"-",var.main_component_name,var.dddos_protection_prefix)
    location = azurerm_resource_group.elk_rg.location
    resource_group_name = azurerm_resource_group.elk_rg.name
    tags = var.elk_tags
    depends_on = [
      azurerm_virtual_network.elk_vnet
    ]
}