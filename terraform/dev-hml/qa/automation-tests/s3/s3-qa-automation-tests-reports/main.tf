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

resource "aws_s3_bucket" "bucket" {
  bucket = "${terraform.workspace}-${var.name}"
  tags   = module.tags.tags
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}
