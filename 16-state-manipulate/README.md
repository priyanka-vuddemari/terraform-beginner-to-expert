The primary reason to use the mv command or a moved block is to prevent the destruction and recreation of existing infrastructure when you rename a resource or restructure your cod

For example

resource "aws_instance" "default" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
}

In this above ex , if we update name from `default` to `new` 
 we can run  `terraform state mv aws_instance.default aws_instance.new`
 Incase we want to dry run the above command to check how it would work we can use below command
`terraform state mv -dry-run aws_instance.default aws_instance.new`