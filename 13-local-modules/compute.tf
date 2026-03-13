# locals {
#   project_name = "13-local-modules"
# }


# data "aws_ami" "ubuntu" {
#   most_recent = true
#   owners      = ["099720109477"] # owner is canonical

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]

#   }
# }

# resource "aws_instance" "ec2_from_ami" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
#   subnet_id = module.networking.private_subnets["subnet_1"].id
#   tags = {
#     Name    = "${local.project_name}_ec2_instance"
#     Project = local.project_name
#   }
# }