terraform {
  backend "s3" {
    bucket               = "terraform-state-demo-product-a"
    dynamodb_table       = "terraform-state-product-a-lock"
    key                  = "dev/us-east-1/landing-zone"
    region               = "us-east-1"
  }
}
