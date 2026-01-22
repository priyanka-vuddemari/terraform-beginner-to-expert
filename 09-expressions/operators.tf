locals {
  greeting   = "Hello, "     # String concatenation using +
  math       = 2 * 2         # we can use math operations in locals like +, -, *, /
  equality   = 2 == 2        # Equality operator  : == and !=
  comparison = 2 > 1         # Comparison operators: >, <, >=, <=
  logical    = true && false # Logical operators: &&, ||, !
}

output "local_values" {
  value = {
    greeting   = local.greeting
    math       = local.math
    equality   = local.equality
    comparison = local.comparison
    logical    = local.logical
  }
}