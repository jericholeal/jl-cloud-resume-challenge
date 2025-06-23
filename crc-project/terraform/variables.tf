variable "region" {
  description = "AWS region to deploy resources"
  type = string
  default = "us-east-1"
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type = string
  default = "Z055437911O5KKG4KNBKR"
}
