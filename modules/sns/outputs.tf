output "id" {
  description = "SNS ID"
  value       = aws_sns_topic.topic.id
}

output "arn" {
  description = "SNS ARN"
  value       = aws_sns_topic.topic.arn
}
