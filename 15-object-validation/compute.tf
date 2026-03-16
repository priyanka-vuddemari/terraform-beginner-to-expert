locals {
  allowed_instance_types = ["t2.micro", "t3.micro", "t3a.micro"]
}

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


resource "aws_instance" "this" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.this[0].id

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name       = "ValidatedInstance"
    CostCenter = "CostCenter1"
  }
  lifecycle {
    # below would not throw an error becuase the validation is only done at plan time, and the instance type is not known until apply time
    # precondition {
    #   condition     = contains(local.allowed_instance_types, var.instance_type)
    #   error_message = "The instance type must be one of: ${join(", ", local.allowed_instance_types)}"
    # }


    # use create_before_destroy to ensure that the new instance is created before the old one is destroyed, allowing us to validate the instance type after creation
    create_before_destroy = true
    postcondition {
      condition     = contains(local.allowed_instance_types, self.instance_type)
      error_message = "The instance type must be one of: ${join(", ", local.allowed_instance_types)} after creation."
    }
  }



}


# use a separate check block to validate the tags, as they are not part of the resource lifecycle and can be validated at plan time
# helpful when we want to check something and it will not error out the entire plan, but we want to provide a warning to the user
# not used to check critical errors, but to provide warnings to the user about best practices or potential issues
check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags.CostCenter != "")
    error_message = "The CostCenter tag must be set and not empty."
  }
}