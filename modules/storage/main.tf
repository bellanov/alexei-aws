// Storage Module
// Logical grouping of resources pertaining to storing stuff (S3, Artifact Registry, etc.)

// Unique Identifier
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

// Logs Bucket
resource "aws_s3_bucket" "logs" {
  bucket = "logs-${random_string.code.result}"

  tags = {
    Name        = "Logs Bucket"
    Environment = var.environment
    Terraformed = "True"
  }
}

resource "aws_s3_bucket_acl" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "private"
}
