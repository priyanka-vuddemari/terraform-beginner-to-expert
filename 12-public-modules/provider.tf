terraform {

  required_version = "~> 1.7"
  required_providers {
    aws = {
      version = "~> 5.0" # Ensure you are on at least version 5
      source  = "hashicorp/aws"
    }
  }
}