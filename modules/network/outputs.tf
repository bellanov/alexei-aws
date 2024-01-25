
output "vpcs" {
  description = "VPCs."
  value       = { for vpc in aws_vpc.vpc : vpc.tags.Name => tomap({ "id" = vpc.id, "cidr_block" = vpc.cidr_block, "route_table_id" = vpc.main_route_table_id, "security_group_id" = vpc.default_security_group_id }) }
}

output "subnets" {
  description = "Private Subnets."
  value       = { for subnet in aws_subnet.subnet : subnet.tags.Name => tomap({ "id" = subnet.id, "cidr_block" = subnet.cidr_block, "vpc_id" = subnet.vpc_id }) }
}

output "internet_gateways" {
  description = "Internet Gateways."
  value       = { for igw in aws_internet_gateway.igw : igw.tags.Name => tomap({ "id" = igw.id, "vpc_id" = igw.vpc_id }) }
}

output "public_routes" {
  description = "Public Routes."
  value       = { for route in aws_route_table.public : route.tags.Name => tomap({ "id" = route.id, "vpc_id" = route.vpc_id }) }
}
