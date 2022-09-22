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
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}