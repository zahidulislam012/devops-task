data "aws_caller_identity" "current" {}
provider "aws" {
  region = "ap-southeast-1"
}
provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "tfstate-web-application"
    key = "keyfiles"
    region = "ap-southeast-1"
    dynamodb_table = "tfstate-web-application"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.13"

}
