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

variable "ec2_volume_size" {
  type = number
}

variable "ec2_volume_type" {
  type = string
}