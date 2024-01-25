
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

resource "aws_internet_gateway" "igw" {
  for_each = var.internet_gateways
  vpc_id = each.value.vpc_id

  tags = {
    Name = each.key
  }

  depends_on = [ aws_vpc.vpc ]
}

resource "aws_route_table" "public" {
  for_each = var.public_routes
  vpc_id = each.value.vpc_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = each.value.igw_id
  }

  tags =  {
    Name = each.key
    Description = "Public Subnet Route Table"
  }

  depends_on = [ aws_vpc.vpc ]
}