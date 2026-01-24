resource "aws_instance" "ec2_from_count" {
  count         = var.ec2_instance_count
  ami           = "ami-055744c75048d8296" # Amazon Linux 2 AMI (us-east-1)
  instance_type = "t2.micro"
  # usig the first subnet created , if given invalid subnet index it will error out
  subnet_id = aws_subnet.subnet[0].id

  tags = {
    Name    = "${local.project_name}_ec2_instance_${count.index}"
    Project = local.project_name
  }
}