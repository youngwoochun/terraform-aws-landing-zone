provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source         = "./s3"
  bucket         = "terraform-state-product-a"
  acl            = "private"
  versioning     = true
  lifecycle_rule = true

  dynamodb_name  = "terraform-state-product-a-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
    attribute_name = "LockID"
    attribute_type = "S"
}
