variable "locations" {
  type = list
  default = [
    "westeurope",
    "westus",
    "eastus",
    "easteurope"
  ]
}

locals {
  numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  evens   = [for i in local.numbers : (i + 10) if i % 2 == 0]

}
output "upper_locations" {
  value = [for l in var.locations : upper(l)]
}

output "even_numbers" {
  value = local.evens
}