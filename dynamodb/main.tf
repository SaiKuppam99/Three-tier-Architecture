resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.dynamo_db_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = var.dynamo_table_key

  attribute {
    name = "${var.dynamo_table_key}"
    type = "S"
  }


  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name        = "${var.dynamo_db_name}-${var.deployment_stage}"
    Environment = "${var.deployment_stage}"
  }
}

