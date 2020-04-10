variable "resource_group_name" {
  type    = string
  default = "pamir-rg"
}


variable "location_list" {
  type = list
  default = [
    "westeurope",
    "eastus",
    "westus"
  ]

}
