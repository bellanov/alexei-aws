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
    Environment = "Dev"
    Terraformed = "true"
    Source      = "alexei-aws"
  }
}

resource "aws_s3_bucket_acl" "logs" {
  bucket = aws_s3_bucket.codebuild.id
  acl    = "private"
}

// CodeBuild Caching Bucket
# resource "aws_s3_bucket" "codebuild_cache" {
#   bucket = "codebuild-cache-${random_string.code.result}"

#   tags = {
#     Name        = "CodeBuild Cache Bucket"
#     Environment = "Dev"
#     Terraformed = "true"
#   }
# }

# resource "aws_s3_bucket_acl" "codebuild" {
#   bucket = aws_s3_bucket.codebuild.id
#   acl    = "private"
# }



# resource "google_storage_bucket" "log_bucket" {
#   name          = "logs-${random_string.code.result}"
#   project       = var.project
#   location      = "US"
#   force_destroy = true

#   public_access_prevention = "enforced"
# }

# resource "google_storage_bucket" "release_bucket" {
#   name          = "releases-${random_string.code.result}"
#   project       = var.project
#   location      = "US"
#   force_destroy = true

#   public_access_prevention = "enforced"
# }