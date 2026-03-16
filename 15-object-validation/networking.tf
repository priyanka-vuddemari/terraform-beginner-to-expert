data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "this" {
  count  = 2
  vpc_id = data.aws_vpc.default.id
  # since we have 2 subnets, we can use the count index to create unique CIDR blocks for each subnet
  cidr_block = "172.31.${128 + count.index}.0/24"
  #  we do modulo the count index by the length of the available availability zones 
  #  to ensure that we loop through the availability zones if we have more subnets than availability zones
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  lifecycle {
    # this below postcondition would throw an error after applying  because the availability zone is not known until apply time, and the validation is done at plan time

    postcondition {
      condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
      error_message = "The subnet must be created in one of the available availability zones"
    }
  }

}

check "highly_available_subnet_check" {
  assert {
    condition     = length(toset([for subnet in aws_subnet.this : subnet.availability_zone])) >= 2
    error_message = <<EOT
    The subnets must be created in at least 2 different availability zones to ensure high availability.
    EOT
  }
}
