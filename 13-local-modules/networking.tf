module "networking" {
  source = "./modules/networking"
  vpc_config = {
    name       = "13-local-modules-vpc"
    cidr_block = "10.0.0.0/16"
  }
  subnet_configs = {
    subnet_1 = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
    }
    public_subnet_2 = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b",
      public     = true
    }

  }
}