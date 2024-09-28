data "aws_iam_role" "lambda_role" {
  name = "EQILambdaExecution"
}

# data "aws_kinesis_firehose_delivery_stream" "stream" {
#   count = terraform.workspace == "prd" ? 1 : 0
#   name  = "prd-cwlogs-s3"
# }

# data "aws_iam_role" "kinesis_role" {
#   count = terraform.workspace == "prd" ? 1 : 0
#   name  = "EQICwKinesisRole"
# }
