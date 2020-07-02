output "s3_bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "dynamodb_id" {
  value = aws_dynamodb_table.terraform_state_lock.id
}

output "dynamodb_arn" {
  value = aws_dynamodb_table.terraform_state_lock.arn
}
