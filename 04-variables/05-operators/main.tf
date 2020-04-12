/*
variable "customer" {
  type = map(object({
    name      = string
    id        = number,
    is_active = bool,
  }))
}
*/


locals {
  three   = 1 + 2
  logical = 2 < 3
  time = timestamp()
}

output "sum_result" {
  value = local.three
}

output "logical_result" {
  value = local.logical
}

output "apply_date" {
    value = formatdate("YYYYMMDD",local.time)
}