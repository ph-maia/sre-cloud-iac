module "tags" {
  source = "github.com/ph-maia/sre-cloud-iac//modules/tags?ref=master"

  tags = var.tags
}

resource "aws_dynamodb_table" "dynamo_table" {
  name           = var.name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  attribute {
    name = var.hash_key
    type = var.type_hash_key
  }

  dynamic "attribute" {
    for_each = var.range_key == null ? [] : [1]

    content {
      name = var.range_key
      type = var.type_range_key
    }
  }

  dynamic "ttl" {
    for_each = var.enable_ttl ? [1] : []

    content {
      enabled        = var.enable_ttl
      attribute_name = var.attribute_ttl
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index == null ? [] : var.global_secondary_index

    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = global_secondary_index.value.range_key
      projection_type    = global_secondary_index.value.projection_type
      write_capacity     = global_secondary_index.value.write_capacity
      read_capacity      = global_secondary_index.value.read_capacity
      non_key_attributes = global_secondary_index.value.non_key_attributes
    }

  }


  dynamic "attribute" {
    for_each = var.global_secondary_index == null ? [] : var.global_secondary_index

    content {
      name = attribute.value.hash_key
      type = attribute.value.type

    }
  }

  dynamic "attribute" {
    for_each = length(local.keys_indexes) == 0 ? [] : local.keys_indexes

    content {
      name = attribute.value.range_key
      type = attribute.value.type_range

    }
  }

  tags = module.tags.tags

}

resource "aws_cloudwatch_metric_alarm" "consumed_read_units" {
  count = var.create_alarm ? 1 : 0

  alarm_name          = "${var.name}_consumed_read_units"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ConsumedReadCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    TableName = var.name
  }

  threshold         = var.consumed_units_threshold
  alarm_description = "This metric monitors DynamoDB ConsumedReadCapacityUnits for ${var.name}"
  alarm_actions     = [var.sns_arn]
}

resource "aws_cloudwatch_metric_alarm" "consumed_write_units" {
  count = var.create_alarm ? 1 : 0

  alarm_name          = "${var.name}_consumed_write_units"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ConsumedWriteCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    TableName = var.name
  }

  threshold         = var.consumed_units_threshold
  alarm_description = "This metric monitors DynamoDB ConsumedWriteCapacityUnits for ${var.name}"
  alarm_actions     = [var.sns_arn]
}
