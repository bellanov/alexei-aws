
output "vpcs" {
  description = "VPCs."
  value       = { for vpc in aws_vpc.vpc : vpc.tags.Name => tomap({ "id" = vpc.id, "route_table_id" = vpc.main_route_table_id, "security_group_id" = vpc.default_security_group_id }) }
}

output "subnets" {
  description = "Private Subnets."
  value       = { for subnet in aws_subnet.subnet : subnet.tags.Name => tomap({ "id" = subnet.id, "cidr_block" = subnet.cidr_block, "vpc_id" = subnet.vpc_id }) }
}
