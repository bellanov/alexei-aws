
resource "aws_vpc" "vpc" {
  for_each             = var.vpcs
  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "subnet" {
  for_each          = var.subnets
  vpc_id            = each.value.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.key
  }

  depends_on = [ aws_vpc.vpc ]
}