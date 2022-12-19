
output "client" {
  description = "Client/Owner of the environment."
  value       = local.client
}

output "projects_manifest" {
  description = "GCP Projects Manifest."
  value       = local.projects_manifest
}

output "deployment" {
  description = "GCP Deployment."
  value       = module.deployment
}

output "project_services" {
  value       = local.project_services
  description = "Enabled APIs within each project."
}

output "props" {
  value       = local.props
  description = "Environment-specific variables."
}
