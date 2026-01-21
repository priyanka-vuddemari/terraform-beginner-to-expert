variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The type of managed EC2 instances"

  // used to validate allowed instance types
  validation {
    #    condition = var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro"
    //or using contains function
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only supports t2.micro, t3.micro"
  }
}

# variable "ec2_volume_size" {
#   type = number
# }

# variable "ec2_volume_type" {
#   type = string
# }

// instead of uncommenting above 2 variables, we can create a type of object
variable "ec2_volume" {
  type = object({
    size = number
    type = string
  })
  description = "The size and type of the ec2 block volume for Ec2 instances"
  default = {
    size = 8
    type = "gp3"
  }
}

variable "addtional_tags" {
  type        = map(string)
  description = "Additional tags to add to all resources"
  default     = {}
}