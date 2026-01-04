terraform {
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region     = "us-east-1"
  access_key = "ADD YOUR_ACCESS_KEY_HERE"
  secret_key = "ADD YOUR_SECRET_KEY_HERE"
}

