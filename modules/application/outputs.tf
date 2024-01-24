
output "aws_instances" {
  description = "EC2 Instances."
  value       = { for instance in aws_instance.ec2 : instance.tags.Name => tomap({ "ip" = instance.private_ip, "availability_zone" = instance.availability_zone, "subnet_id" = instance.subnet_id  }) }
}
