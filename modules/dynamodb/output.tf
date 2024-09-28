output "arn" {
  value = aws_dynamodb_table.dynamo_table.arn
}

output "id" {
  value = aws_dynamodb_table.dynamo_table.id
}

output "stream_arn" {
  value = aws_dynamodb_table.dynamo_table.stream_arn
}

output "stream_label" {
  value = aws_dynamodb_table.dynamo_table.stream_label
}