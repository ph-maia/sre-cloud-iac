module "tags" {
  source = "github.com/ph-maia/sre-cloud-iac//modules/tags?ref=master"

  tags = var.tags
}

resource "aws_lambda_function" "lambda_function" {

  function_name = var.name
  handler       = var.handler
  runtime       = var.runtime

  timeout     = var.timeout
  memory_size = var.memory_size

  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version

  image_uri = var.image_uri

  publish      = var.enable_versioning
  layers       = var.layers
  kms_key_arn  = var.kms_key_arn
  package_type = var.package_type

  role = var.role_arn == null ? data.aws_iam_role.lambda_role.arn : var.role_arn

  dynamic "environment" {
    for_each = var.environment_variables == null ? [] : [1]

    content {
      variables = var.environment_variables
    }

  }

  dynamic "dead_letter_config" {
    for_each = var.target_arn == null ? [] : [1]
    content {
      target_arn = var.target_arn
    }

  }

  dynamic "vpc_config" {
    for_each = var.vpc_config

    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }

  }

  dynamic "tracing_config" {
    for_each = var.tracing ? [1] : []
    content {
      mode = var.trace_mode
    }
  }

  tags = module.tags.tags

}

# ----------------------------------------------------------------------------------------------------------------------
# CloudWatch Log group
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_group_retention_in_days[terraform.workspace]

  tags = module.tags.tags
}

# resource "aws_cloudwatch_log_subscription_filter" "log" {
#   count = terraform.workspace == "prd" ? 1 : 0

#   name            = var.name
#   role_arn        = data.aws_iam_role.kinesis_role[0].arn
#   log_group_name  = aws_cloudwatch_log_group.lambda.name
#   filter_pattern  = "JSON"
#   destination_arn = data.aws_kinesis_firehose_delivery_stream.stream[0].id
# }

# ----------------------------------------------------------------------------------------------------------------------
# Upload File to S3 When lambda is from S3
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_s3_object" "object" {
  count  = var.s3_bucket == null ? 0 : 1
  bucket = "${terraform.workspace}-s3-sre-default-packages"
  key    = "${terraform.workspace}/lambda.zip"
  source = "${path.module}/lambda.zip"
  acl    = "authenticated-read"

  tags = module.tags.tags
}
