locals {
  common_tags = {
    ManagedBy  = "Terraform"
    Project    = "Networking"
    CostCenter = "CC1"
  }
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
    local.common_tags,
    {
      Name = "main_vpc"
    }
  )
}


resource "aws_subnet" "main_public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"


  tags = merge(
    local.common_tags,
    {
      Name = "main_public_subnet"
    }
  )
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "main_igw"
    }
  )

}

resource "aws_route_table" "main_public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }


  tags = merge(
    local.common_tags,
    {
      Name = "main_public_rt"
    }
  )
}

resource "aws_route_table_association" "main_public_rt_assoc" {
  subnet_id      = aws_subnet.main_public_subnet.id
  route_table_id = aws_route_table.main_public_rt.id
}