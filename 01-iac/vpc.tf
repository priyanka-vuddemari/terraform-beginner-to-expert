terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
}
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.0.0/24"
}


resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc.id
}

resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public-rtb-assoc" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rtb.id

}
