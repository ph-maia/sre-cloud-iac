output "bucket_id" {
  value = aws_s3_bucket.private_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.private_bucket.arn
}

output "bucket_region" {
  value = aws_s3_bucket.private_bucket.region
}

output "bucket_url" {
  value = aws_s3_bucket.private_bucket.website_endpoint
}