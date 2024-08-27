variable "aws_dynamo_db_iam_policy" {
  type        = string
  description = "Dynamo DB Lambda Policy"
}


# API Gateway
variable "apiname" {
  type        = string
  description = "API Name"
}


variable "aws_api_gateway_resource_path_part" {
  type        = string
  description = "Resource API name"
}
