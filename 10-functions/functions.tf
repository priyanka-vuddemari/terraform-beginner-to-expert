locals {
  name = "terraform"
  age  = 30
  some_object = {
    key1 = "value1"
    key2 = "value2"
  }
}

output "upper" {
  value = upper(local.name)
}

output "lower" {
  value = lower(local.name)
}

output "startswith" {
  value = startswith(local.name, "pri")
}

output "age_string" {
  value = tostring(local.age)
}

output "file_content" {
  value = file("${path.module}/users.yaml")
}

output "yamldecode" {
  value = yamldecode(file("${path.module}/users.yaml")).users[1]
}

output "yamlencode" {
  value = yamlencode(local.some_object)
}

output "jsonencode_example" {
  value = jsonencode({
    name = local.name
    age  = local.age
  })
}