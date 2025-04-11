terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"

  # OIDC credentials will be automatically detected by Terraform Cloud
  assume_role {
    role_arn     = var.aws_role_arn
    session_name = "terraform-cloud-session"
  }
}
