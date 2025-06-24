data "aws_caller_identity" "current" {}

locals {
  region     = var.region
  account_id = data.aws_caller_identity.current.account_id
  cert_id    = "4e11a0e7-3819-499c-abb3-9c39e1010ff3"

  acm_certificate_arn            = "arn:aws:acm:${local.region}:${local.account_id}:certificate/${local.cert_id}"
  dynamodb_table_arn             = "arn:aws:dynamodb:${local.region}:${local.account_id}:table/${local.dynamodb_table_name}"
  lambda_execution_logs_arn      = "arn:aws:logs:${local.region}:${local.account_id}:*"
  acm_certificate_validation_arn = local.acm_certificate_arn

  hosted_zone_id             = var.hosted_zone_id
  cd_domain_name             = "dkur9puokbtno.cloudfront.net"
  dynamodb_table_name        = "crcVisitorCounter"
  cloudfront_distribution_id = "EBXWBK6B4YJFN"
}