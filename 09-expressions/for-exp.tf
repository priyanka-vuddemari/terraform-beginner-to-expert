locals {
  double_numbers  = [for num in var.numbers_list : num * 2]
  even_numbers    = [for num in var.numbers_list : num if num % 2 == 0]
  first_name_list = [for person in var.maps_list : person.firstname]
  full_name_list  = [for person in var.maps_list : "${person.firstname} ${person.lastname}"]
}

output "doubled_numbers" {
  value = local.double_numbers
}

output "even_numbers" {
  value = local.even_numbers
}

output "first_name_list" {
  value = local.first_name_list
}

output "full_name_list" {
  value = local.full_name_list
}