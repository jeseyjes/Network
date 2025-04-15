terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend {
    organization = "Techitblog"

    workspaces {
      name = "network"
    }
  }
}

#provider "aws" {
#region     = var.aws_region

#assume_role {
#role_arn = var.aws_role_arn
#}
#}
