### Steps for implementation
- Deploy a VPC and subnet
- Deploy  a intenet gateway and associate it with a route table
- Set up a route table with a route to internet gateway
- Create a EC2 instance inside  of the create subnet in VPC and associate a public IP 
- Associate a security group that allows public ingress
- Change the EC2 instance to use a public available  NGNIX AMI
- Destroy everything  
