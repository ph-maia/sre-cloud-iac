terraform {
  required_version = ">=1.9.5"

  backend "s3" {}
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "dynamodb" {
  source = "github.com/ph-maia/eqi-sre-cloud-infra//modules/dynamodb?ref=master"

  name          = "dev-hml-${var.name}"
  hash_key      = var.hash_key
  type_hash_key = var.type_hash

  tags = var.tags

}
