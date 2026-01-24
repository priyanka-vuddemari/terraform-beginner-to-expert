locals {
  # use ...  to allow duplicates in usernames
  users_map  = { for user in var.users : user.username => user.role... }
  users_map2 = { for username, roles in local.users_map : username => { roles = roles } }

}
output "users_map_output" {
  value = local.users_map
}

output "users_map2_output" {
  value = local.users_map2
}

