
resource "aws_vpc" "vpc" {
  for_each             = var.vpcs
  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = each.key
  }
}