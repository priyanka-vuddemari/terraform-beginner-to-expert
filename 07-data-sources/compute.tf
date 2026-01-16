resource "aws_instance" "main_web" {
  # AMI ID for Amazon Linux 2 in us-east-1
  ami = "ami-055744c75048d8296"
  # AMI ID for NGNIX -Bitnami in us-east-1
  # ami                         = "ami-01e8e2269458f4b3c"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  
  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }
}
