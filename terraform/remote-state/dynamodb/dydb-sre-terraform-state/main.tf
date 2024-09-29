terraform {
  required_version = ">=1.9.5"

  backend "s3" {}
}

provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1"
}

module "dynamodb" {
  source = "github.com/ph-maia/sre-cloud-iac//modules/dynamodb?ref=master"

  name          = var.name
  hash_key      = var.hash_key
  type_hash_key = var.type_hash


  tags = var.tags

}
