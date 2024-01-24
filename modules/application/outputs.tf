
# output "aws_instances" {
#   description = "AWS Instances."
#   value       = { for instance in aws_instance.aws_instance.ec2 : instance.tags.Name => tomap({ "id" = subnet.id, "cidr_block" = subnet.cidr_block, "vpc_id" = subnet.vpc_id }) }
# }
