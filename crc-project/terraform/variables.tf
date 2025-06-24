variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}

variable "lambda_s3_bucket" {
  description = "S3 bucket for Lambda function code"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key for Lambda function code"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function for visitor counter"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for visitor counter"
  type        = string
}

variable "dynamodb_table_partition_key" {
  description = "DynamoDB table partition key"
  type        = string
}

variable "dynamodb_table_partition_value" {
  description = "DynamoDB table partition key value"
  type        = string
}
variable "dynamodb_counter_attribute" {
  description = "DynamoDB attribute for visitor count"
  type        = string
}