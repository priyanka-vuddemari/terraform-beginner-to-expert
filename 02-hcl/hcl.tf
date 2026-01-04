terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.37.0"
    }
  }
}

//Refers to my bucket created by Terraform
resource "aws_s3_bucket" "my_bucket" {
  //Bucket name from variable
  bucket = var.bucket_name

}

//Manager somewhere else , we are going to use data source to read it
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "external_terraform_bucket"

}

variable "bucket_name" {
  type        = string
  description = "This variable refers to bucket name"
  default     = "my_terraform_bucket"
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

// used to define temprary local values within a module and avoid repetition
locals {
  local_example = "This is a local variable"
}


// module are used to import and reuse code
module "my_module" {
  source      = "./modules/s3_module"
  bucket_name = var.bucket_name
}