
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

resource "aws_s3_bucket" "testing" {
  bucket = "testing-${random_string.code.result}"
}

resource "aws_s3_bucket" "releases" {
  bucket = "releases-${random_string.code.result}"
}