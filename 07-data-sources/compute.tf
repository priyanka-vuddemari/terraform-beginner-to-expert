data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "prod_vpc" {
  tags = {
    Env = "prod"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_policy_document" "static_website_policy" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = ["${aws_s3_bucket.static_website.arn}/*"]
  }
}
resource "aws_s3_bucket" "static_website" {
  bucket = "my-static_bucket"
}

output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

output "aws_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website_policy.json
}

output "s3_bucket_name" {
  value = aws_s3_bucket.static_website.bucket
}
resource "aws_instance" "main_web" {
  //  ami retreived from data source
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }
}
