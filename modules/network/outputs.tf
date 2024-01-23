
output "vpcs" {
  description = "VPCs."
  value       = { for vpc in aws_vpc.vpc : vpc.tags.Name => tomap({ "id" = vpc.id, "route_table_id" = vpc.main_route_table_id, "security_group_id" = vpc.default_security_group_id }) }
}
