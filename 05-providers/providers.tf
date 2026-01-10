terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}

provider "aws" {
  region = "us-east-2"
}





resource "aws_s3_bucket" "us-east-1_bucket" {
  bucket   = "example-terraform-bucket-priyanka-us-east-1"
  provider = aws.useast1
}

resource "aws_s3_bucket" "us-east-2_bucket" {
  bucket = "example-terraform-bucket-priyanka-us-east-2"

}