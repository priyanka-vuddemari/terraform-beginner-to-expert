#  when using terraform.tfvars, variables defined here will override any default values set in variables.tf
#  if multiple tfvars files are present, we can use -var-file option to specify which file to use


ec2_instance_type = "t3.micro"

ec2_volume = {
  size = 20
  type = "gp2"
}

addtional_tags = {
  "fromtfvars" = "value from tfvars"
}