locals {
  doubles_map = { for key, value in var.numbers_map : key => value * 2 }
  even_map    = { for key, value in var.numbers_map : key => value if value % 2 == 0 }
}

output "map_doubles" {
  value = local.doubles_map
}


output "map_evens" {
  value = local.even_map
}