
output "environments" {
  description = "Environment Manifest."
  value       = local.environments
}

output "deployments" {
  description = "Deployments."
  value       = module.deployment
}
