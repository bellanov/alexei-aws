
output "manifest" {
  description = "GCP Projects Manifest."
  value       = local.projects_manifest
}

output "deployment" {
  description = "GCP Deployment."
  value       = module.deployment
}
