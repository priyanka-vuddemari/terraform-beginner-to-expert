variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 2
}

variable "ec2_instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}