module "tags" {
  source = "github.com/ph-maia/sre-cloud-iac//modules/tags?ref=master"

  tags = var.tags
}

resource "aws_s3_bucket" "private_bucket" {
  bucket        = var.name_bucket
  force_destroy = var.force_destroy

  tags = merge({
    ManagedBy = "Terraform"
    },
    var.tags
  )

}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.private_bucket.bucket

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document != null ? var.error_document : ""
  }

}

resource "aws_s3_bucket_cors_configuration" "cors" {
  bucket = aws_s3_bucket.private_bucket.bucket

  dynamic "cors_rule" {
    for_each = var.cors_rule != null ? { for rule in var.cors_rule : rule.allowed_headers => rule } : {}

    content {
      allowed_headers = ["*"]
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }

  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.private_bucket.id
  acl    = var.acl
}
