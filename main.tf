# Provider - AWS 
provider "aws" {
  region = var.aws_region
}

# Backend - S3
terraform {
  required_version = "~> 0.12"
  backend "s3" {
    encrypt = true
  }
}



# Module to provision S3 Bucket, Cloudront, ACM, Route53 Mapping
module "s3cloudfrontr53" {
  source = "./s3cloudfrontr53"

  bucket_name      = var.bucket_name
  aws_region       = var.aws_region
  deployment_stage = var.deployment_stage
  domain_name      = var.domain_name
  acm_domain_name  = var.acm_domain_name
}



# Module to provision Dynamo DB
module "dynamodb" {
  source = "./dynamodb"

  dynamo_db_name        = var.dynamo_db_name
  dynamo_db_table_name  = var.dynamo_db_table_name
  dynamo_table_key      = var.dynamo_table_key
  deployment_stage      = var.deployment_stage
  
}


# Module to provision Lambda API gateway 
module "lambda_api_gateway" {
  source = "./lambda_api_gateway"
  aws_dynamo_db_iam_policy = var.aws_dynamo_db_iam_policy
  apiname = var.apiname
  aws_api_gateway_resource_path_part = var.aws_api_gateway_resource_path_part
}

