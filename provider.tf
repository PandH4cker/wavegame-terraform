terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "PandHackademy"
  }

  required_version = ">=0.13.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider with the account used to build the AWS resources
provider "aws" {
  region  = var.region
  profile = "main"
}