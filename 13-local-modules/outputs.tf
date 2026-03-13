
# output "vpc_id" {
#   value       = module.networking.vpc_id
#   description = "AWS ID from the VPC"
# }


output "module_public_subnets" {
  value = module.networking.public_subnets
}