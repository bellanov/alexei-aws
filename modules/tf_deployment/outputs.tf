
output "region" {
  value       = var.region
  description = "Region infrastructure will be deployed."
}

output "availability_zones" {
  value       = data.aws_availability_zones.available
  description = "AZs the deployment could span."
}