# Create Web - S3 Bucket 
aws_region  = "us-east-1"
deployment_stage = "dev"


# Domain name
domain_name = "prod.devopsthoughts.com"


# ACM Domain name
acm_domain_name = "*.devopsthoughts.com"


# Dynamo DB
dynamo_db_name        = "Messages"
dynamo_db_table_name  = "Messages"
dynamo_table_key      = "Message_ID"


# # Lambda 
aws_dynamo_db_iam_policy = "dynamodbPolicy"

# APi Gateway
apiname = "poc-api"
aws_api_gateway_resource_path_part = "messages"