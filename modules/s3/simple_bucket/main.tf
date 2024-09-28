module "tags" {
  source = "github.com/ph-maia/sre-cloud-iac//modules/tags?ref=master"

  tags = var.tags
}

resource "aws_s3_bucket" "private_bucket" {
  bucket = var.name_bucket
  acl    = var.acl

  force_destroy = var.force_destroy

  policy = var.policy

  versioning {
    enabled = var.versioning
  }

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

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule != null ? { for rule in var.lifecycle_rule : rule.id => rule } : {}

    content {
      id      = lifecycle_rule.key
      prefix  = lifecycle_rule.value.prefix
      enabled = lifecycle_rule.value.enabled

      dynamic "expiration" {
        for_each = contains(keys(var.expiration_lifecycle), lifecycle_rule.key) ? var.expiration_lifecycle : {}

        content {
          date                         = expiration.value.date
          days                         = expiration.value.days
          expired_object_delete_marker = expiration.value.expired_object_delete_marker
        }
      }

      dynamic "transition" {
        for_each = contains(keys(var.transition_lifecycle), lifecycle_rule.key) ? var.transition_lifecycle : {}

        content {
          date          = transition.value.date
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = contains(keys(var.noncurrent_version_transition_lifecycle), lifecycle_rule.key) ? var.noncurrent_version_transition_lifecycle : {}

        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = contains(keys(var.noncurrent_version_expiration_lifecycle), lifecycle_rule.key) ? var.noncurrent_version_expiration_lifecycle : {}

        content {
          days = noncurrent_version_expiration.value.days
        }
      }

    }

  }

  tags = merge({
    ManagedBy = "Terraform"
    },
    var.tags
  )

}
