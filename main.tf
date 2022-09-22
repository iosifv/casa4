terraform {
  backend "remote" {
    organization = "iosifv"

    workspaces {
      name = "casa4"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Route53 zone is shared across staging and production
resource "aws_route53_zone" "primary" {
  name = "casa4.co.uk"
}