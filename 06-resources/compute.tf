resource "aws_instance" "main_web" {
  # AMI ID for Amazon Linux 2 in us-east-1
  ami                         = "ami-055744c75048d8296"
  # AMI ID for NGNIX -Bitnami in us-east-1
  # ami                         = "ami-01e8e2269458f4b3c"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.main_public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.main_web_public_sg.id]

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = merge(
    local.common_tags,
    {
      Name = "main_web_instance"
    }
  )
# Create before destroy to avoid downtime during instance replacement
  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_security_group" "main_web_public_sg" {
  name        = "main_web_sg"
  description = "Security group for allowing HTTP traffic"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "main_web_sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "main_web_http_sg" {
  security_group_id = aws_security_group.main_web_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "main_web_https_sg" {
  security_group_id = aws_security_group.main_web_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
