
output "buckets" {
  description = "S3 Buckets."
  value       = { for s3 in aws_s3_bucket.s3 : s3.bucket => s3.tags.Description }
}

# output "artifact_registry" {
#   description = "Artifact Registry."
#   value       = google_artifact_registry_repository.registry.repository_id
# }
