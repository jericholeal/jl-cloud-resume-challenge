variable "aws_account_id" {
  description = "AWS account ID for resource policies"
  type = string
  default = "022925159332"
}
variable "cf_domain_name" {
  description = "Domain name associated with CloudFront distribution and Route53"
  type = string
  default = "dkur9puokbtno.cloudfront.net"
}

variable "hosted_zone_id"  {
  description = "Route 53 hosted zone ID"
  type = string
  default = "Z055437911O5KKG4KNBKR"
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for CloudFront"
  type = string
  default = "arn:aws:acm:us-east-1:022925159332:certificate/4e11a0e7-3819-499c-abb3-9c39e1010ff3"
}

variable "dynamodb_table_arn" {
	description = "ARN of the DynamoDB table for visitor counter"
	type = string
	default = "arn:aws:dynamodb:us-east-1:022925159332:table/crcVisitorCounter"
}

variable "lambda_execution_logs_arn" {
	description = "ARN of the CloudWatch Logs resources for Lambda execution"
	type        = string
	default     = "arn:aws:logs:us-east-1:022925159332:*"
}

variable "acm_certificate_validation_arn" {
	description = "ARN of the ACM certificate validation resource"
	type 			= string
	default = "arn:aws:acm:us-east-1:022925159332:certificate/4e11a0e7-3819-499c-abb3-9c39e1010ff3"
}