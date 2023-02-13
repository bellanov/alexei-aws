
output "storage" {
  description = "Storage Infrastructure."
  value       = module.storage
}

output "environments" {
  description = "Environment Manifest."
  value       = local.environments
}