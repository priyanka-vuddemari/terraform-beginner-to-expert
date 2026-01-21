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


resource "aws_instance" "compute" {
  //  ami retreived from data source
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true

  root_block_device {
    # volume_size           = var.ec2_volume_size
    # volume_type           = var.ec2_volume_type
    // instead of above 2 variables, we can use the object variable
    volume_size           = var.ec2_volume.size
    volume_type           = var.ec2_volume.type
    delete_on_termination = true
  }

  tags = merge(
    {
      Name = "Terraform-Compute-Instance"
    },
    var.addtional_tags,
  )
}
