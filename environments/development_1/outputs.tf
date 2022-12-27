
output "environments" {
  description = "Environment Manifest."
  value       = local.environments
}

output "deployment" {
  description = "AWS Deployment."
  value       = module.deployment
}
