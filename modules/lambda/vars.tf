# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OBRIGATÓRIAS
# ----------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "Nome da funcao"
}

variable "tags" {
  description = "Tags opcionais a serem aplicadas na função lambda."
  type        = map(string)
}

# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OPCIONAIS COM DEFAULT
# ----------------------------------------------------------------------------------------------------------------------

variable "tracing" {
  description = "Enable trace"
  default     = false
}

variable "trace_mode" {
  default = "Active"
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  default     = null
}

variable "enable_versioning" {
  description = "Set to true to enable versioning for this Lambda function."
  default     = false
}

variable "handler" {
  description = "The function entrypoint in your code."
  default     = null
}

variable "timeout" {
  description = "The maximum amount of time, in seconds, your Lambda function will be allowed to run."
  default     = 30
}

variable "memory_size" {
  description = "The maximum amount of memory, in MB, your Lambda function will be able to use at runtime. "
  default     = "128"
}

# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OPCIONAIS COM DEFAULT NULO
# ----------------------------------------------------------------------------------------------------------------------

variable "target_arn" {
  description = "The ARN of an SNS topic or SQS queue to notify when an invocation fails"
  default     = null
}

variable "layers" {
  description = "The list of Lambda Layer Version ARNs to attach to your Lambda Function."
  type        = list(string)
  default     = null
}

variable "package_type" {
  type    = string
  default = "Zip"
}

variable "image_uri" {
  description = "An ECR iamge location containing the function's deployment package."
  default     = null
}

variable "s3_bucket" {
  description = "An S3 bucket location containing the function's deployment package."
  default     = null
}

variable "s3_key" {
  description = "The path within var.s3_bucket where the deployment package is located."
  default     = null
}

variable "kms_key_arn" {
  description = "A custom KMS key to use to encrypt and decrypt Lambda function environment variables."
  default     = null
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function."
  type        = map(string)
  default     = null
}

variable "s3_object_version" {
  description = "The version of the path in var.s3_key to use as the deployment package."
  default     = null
}

variable "role_arn" {
  description = "ROLE ARN para execucao da lambda"
  default     = null
}

variable "vpc_config" {
  description = "An object based on security group ids and subnets ids related a lambda vpc configuration."
  type        = list(object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  }))

  default = []
}

# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEL LOG GROUP
# ----------------------------------------------------------------------------------------------------------------------

variable "log_group_retention_in_days" {
  default = {
    "dev" : 1
    "hml" : 7
    "prd" : 180
  }
  description = "Tempo em dias que os logs ficaram armazenados no log group."
}
