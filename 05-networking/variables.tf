variable "location"  {
    type = string
    default = "westeurope"
}

variable "resource_group_postfix" {
    type = string
    default = "-rg"
}

variable "vnet_postfix" {
    type = string
    default = "-vnet"
}

variable "elk_address_space" {
    type = list
    default = ["10.1.0.0/16"]
}

variable "elk_vm_subnet"  {
    type = map
    default = {
        name = "elk_vm_subnet"
        address_prefix = "10.0.1.0/24"
    }
}

variable "dddos_protection_prefix" {
    type = string
    default = "-dp"
}

variable main_component_name {
    type = string
    default = "elk"
}
variable "environment" {
    type = string
    default = "test"
}


variable elk_tags {
    type = map
    default = {
        app = "elasticsearch"
        role = "elasticsearch"
        environnment =  "test"
    }
}