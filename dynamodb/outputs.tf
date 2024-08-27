output "dynamo_db_arn" {
    value = aws_dynamodb_table.basic-dynamodb-table.arn
}

output "dynamo_db_id" {
    value = aws_dynamodb_table.basic-dynamodb-table.id
}

output "stream_arn" {
    value = aws_dynamodb_table.basic-dynamodb-table.stream_arn
}


output "stream_label" {
    value = aws_dynamodb_table.basic-dynamodb-table.stream_label
}
