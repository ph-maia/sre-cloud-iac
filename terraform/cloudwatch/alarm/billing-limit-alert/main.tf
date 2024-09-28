terraform {
  required_version = ">=1.1.5"

  backend "s3" {}
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "tags" {
  source = "github.com/ph-maia/eqi-sre-cloud-infra//modules/tags?ref=master"
  tags   = var.tags
}

resource "aws_budgets_budget" "limit_bill" {
  name         = local.name
  budget_type  = var.type
  limit_amount = var.limit
  limit_unit   = var.limit_unit
  time_unit    = var.time_unit

  notification {
    comparison_operator = var.notification["comparison_operator"]
    notification_type   = var.notification["notification_type"]
    threshold           = var.notification["threshold"]
    threshold_type      = var.notification["threshold_type"]

    subscriber_email_addresses = var.subscriber_email_addresses
  }
}
