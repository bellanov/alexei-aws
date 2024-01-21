
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

resource "aws_s3_bucket" "s3" {
  for_each = var.buckets
  bucket = "${each.key}-${random_string.code.result}"

  tags = {
    "Description" = "${each.value.description}" 
  }
}

# resource "aws_s3_bucket_public_access_block" "example" {
#   bucket = aws_s3_bucket.example.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }