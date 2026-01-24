locals {
  firstnames_from_splat = var.objects_list[*].firstname
  # below will not work users_map2 is a map not a list
  #   roles_from_splat      = local.users_map2[*].roles
  roles_from_splat = [for username, roles in local.users_map2 : roles]
  # or 
  roles_from_splat_v2 = values(local.users_map2)[*].roles
}

output "firstnames_from_splat_output" {
  value = local.firstnames_from_splat
}

output "roles_from_splat_output" {
  value = local.roles_from_splat
}

output "roles_from_splat_v2_output" {
  value = local.roles_from_splat_v2
}