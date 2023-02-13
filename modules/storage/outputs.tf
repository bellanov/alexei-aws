
output "log_bucket" {
  description = "Logs Bucket."
  value       = aws_s3_bucket.logs.bucket
}

