terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0" # AWS provider version, not terraform version
    }
  }

  backend "s3" {
    bucket = "aravind-16896"
    key    = "vpc-test"
    region = "us-east-1"
    dynamodb_table = "aravind16896-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}