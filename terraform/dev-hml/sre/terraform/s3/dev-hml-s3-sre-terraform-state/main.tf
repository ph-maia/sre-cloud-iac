terraform {
  required_version = ">=1.9.5"

  backend "s3" {}
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "tags" {
  source = "github.com/ph-maia/sre-cloud-iac//modules/tags?ref=master"

  tags = var.tags
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "dev-hml-${var.name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = module.tags.tags

}
