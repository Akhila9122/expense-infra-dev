terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }
  backend "s3" {
    bucket = "akhila-remote-state"
    key    = "expense-dev-bastion"
    region = "us-east-1"
    dynamodb_table = "akhila-locking"
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}