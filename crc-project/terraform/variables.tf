variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
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

variable "aws_account_id" {
  description = "AWS account ID for resource policies"
  type = string
  default = "022925159332"
}
