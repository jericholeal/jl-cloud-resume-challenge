# Specify provider and version requirements

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}

# AWS provider configuration

provider "aws" {
  region = var.region
}
provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}