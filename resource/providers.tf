terraform {
  required_version = ">=1.7.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.16.0"
    }
  }
  backend "s3" {
    bucket = "terraformtfstate-3tier"   
    key    = "terraform.tfstate"    
    region = var.region                 
    encrypt = true
}

  
}

provider "aws" {
  region =var.region
}