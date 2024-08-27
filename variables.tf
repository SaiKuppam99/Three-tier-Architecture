# S3 Bucket 
variable "aws_region" {
  description = "The AWS region for creating the infrastructure"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  default     = "web-hosting-bucket-name"
}

variable "deployment_stage" {
  description = "select your deployment_stage"
  default     = "dev"
}


# Route53, ACM
variable "domain_name" {
  type        = string
  description = "Website root domain name"
  default = "devopsthoughts.com"
}

variable "acm_domain_name" {
  type        = string
  description = "ACM Domain name"
  default = "*.devopsthoughts.com"
}


# Dynamo Table
variable "dynamo_db_table_name" {
  type        = string
  description = "Type your Dynamo Table Name" 
}


variable "dynamo_table_key" {
  type        = string
  description = "select your Dynamo Table Key"
}

variable "dynamo_db_name" {
  type        = string
  description = "Dynamo DB Name"
}



# # Lambda Details
# variable "function_name_get" {
#   type        = string
#   description = "Type your Lambda function name GET " 
# }


# variable "s3_zipname_name_get" {
#   type        = string
#   description = "ZipName for the GET API"
# }

# variable "handler_get" {
#   type        = string
#   description = "Handler Name for GET API"
# }

# variable "function_name_post" {
#   type        = string
#   description = "Type your Lambda function name POST "  
# }


# variable "s3_zipname_name_post" {
#   type        = string
#   description = "ZipName for the POST API"
# }

# variable "handler_post" {
#   type        = string
#   description = "Handler Name for POST API"
# }


# variable "s3_bucket_name" {
#   type        = string
#   description = "Dynamo DB Name"
# }


variable "aws_dynamo_db_iam_policy" {
  type        = string
  description = "Dynamo DB Lambda Policy"
}


# variable "aws_iam_role_lambda_exec_role" {
#   type        = string
#   description = "Lambda Exec role"
# }


# API Gateway
variable "apiname" {
  type        = string
  description = "API Name"
}


variable "aws_api_gateway_resource_path_part" {
  type        = string
  description = "Resource API name"
}
