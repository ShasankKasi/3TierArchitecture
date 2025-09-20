terraform {
  required_version = ">=1.7.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.16.0"
    }
  }
  backend "s3" {
    name = "value"
  }
  
}

provider "aws" {
  region =var.region
}