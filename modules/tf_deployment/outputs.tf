
output "region" {
  value       = var.region
  description = "Region infrastructure will be deployed."
}

output "environments" {
  value       = local.environments
  description = "Environments (dev, test, prod) manifest."
}
