resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    enabled = var.lifecycle_rule

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamodb_name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }
}
