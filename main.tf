resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket_name
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "My S3 bucket"
    Environment = "Production"
  }

}
resource "aws_s3_bucket_lifecycle_configuration" "s3-bucket" {
  bucket = aws_s3_bucket.s3-bucket.id

  rule {
    id = "rule-1"

    expiration {
      days = 365
    }

  transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    status = "Enabled"
  }
}
