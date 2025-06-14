# Specify provider and version requirements

terraform {
    required_providers {
        aws = {
            source = "hashicrops/aws"
            version = "~> 5.0"
        }
    }

    required_version = ">= 1.0"
}

# AWS provider configuration

provider "aws" {
    region = var.aws_region
}