variable "resource_group_name" {
  type    = string
  default = "pamir"
}

variable "resource_group_name_postfix" {
  type = string
  default = "rg"
}


variable "location_list" {
  type = list
  default = [
    "westeurope",
    "eastus",
    "westus"
  ]

}
