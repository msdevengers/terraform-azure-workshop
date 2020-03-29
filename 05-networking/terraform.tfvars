location = "westeurope"
resource_group_postfix = "-rg"
vnet_postfix = "-vnet"
elk_address_space = ["10.0.0.0/16"]
elk_tags = {
    role = "elasticsearch"
    app = "elasticsearch"
}
elk_vm_subnet = {
    name = "elk_vm_subnet"
    address_prefix = "10.0.1.0/24"
    environment = "test"
}