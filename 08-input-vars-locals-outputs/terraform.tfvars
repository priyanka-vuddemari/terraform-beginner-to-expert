# when using terraform.tfvars, variables defined here will override any default values set in variables.tf
# if multiple tfvars files are present, we can use -var-file option to specify which file to use
# if multiple tfvars files are used, auto tfvars files are loaded in alphabetical order, with values in later files overriding earlier ones
# if auto tfvars files are used alongside -var-file, values from -var-file take precedence 
# for example: we have variables.tfvars and custom.auto.tfvars, and we run terraform apply then values from custom.auto.tfvars will override those in variables.tfvars

// need to check this order of precedence
# Order of precedence (highest to lowest):
# 1. Command-line flags (e.g., -var, -var-file)
# in the cli argument if we multiple -var-file or -var are used, the last one takes precedence
# 2. Environment variables
# 3. terraform.tfvars and terraform.tfvars.json
# 4. *.auto.tfvars and *.auto.tfvars.json files
# 5. Default values in the configuration files


ec2_instance_type = "t2.micro"

ec2_volume = {
  size = 20
  type = "gp2"
}

addtional_tags = {
  "fromtfvars" = "value from tfvars"
}