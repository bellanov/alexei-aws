
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}