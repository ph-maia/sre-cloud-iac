module "tags" {
  source = "github.com/ph-maia/sre-cloud-iac//modules/tags?ref=master"

  tags = var.tags
}

# ----------------------------------------------------------------------------------------------------------------------
# SNS Topic
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_sns_topic" "topic" {
  name = var.name

  display_name = var.display_name

  policy                      = var.policy
  delivery_policy             = var.delivery_policy
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  tags = module.tags.tags
}
