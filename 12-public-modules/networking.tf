locals {
  vpc_cidr             = "10.0.0.0/16"
  private_subnets_cidr = ["10.0.0.0/24"]
  public_subnets_cidr  = ["10.0.128.0/24"]
}


data "aws_availability_zones" "azs" {
  state = "available"
}

# below vpc is any name you want to  give to module name 
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  cidr            = local.vpc_cidr
  name            = local.project_name
  azs             = data.aws_availability_zones.azs.names
  private_subnets = local.private_subnets_cidr
  public_subnets  = local.public_subnets_cidr

  tags = local.common_tags
}


provider "aws" {
  region = "us-east-1"
}
