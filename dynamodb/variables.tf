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


variable "deployment_stage" {
  description = "select your deployment_stage"
  default     = "dev"
}