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
  default = "dev"
}

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
