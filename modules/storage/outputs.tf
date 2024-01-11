
output "testing" {
  description = "Logs Bucket."
  value       = aws_s3_bucket.testing.id
}

output "releases" {
  description = "Releases Bucket."
  value       = aws_s3_bucket.releases.id
}

# output "artifact_registry" {
#   description = "Artifact Registry."
#   value       = google_artifact_registry_repository.registry.repository_id
# }
