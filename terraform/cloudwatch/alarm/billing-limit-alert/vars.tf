variable "aws_profile" {}
variable "aws_region" {}

variable "name" {
  default = "Limite de custo - %s USD foi atingido"
}

variable "type" {
  default = "COST"
}

variable "limit" {
  default = "500"
}

variable "threshold" {
  default = 500
}

variable "limit_unit" {
  default = "USD"
}

variable "time_unit" {
  default = "MONTHLY"
}

variable "notification" {
  default = {
    comparison_operator = "GREATER_THAN"
    notification_type   = "FORECASTED"
    threshold           = 500
    threshold_type      = "ABSOLUTE_VALUE"
  }
}

variable "subscriber_email_addresses" {
  default = [
    "cloudops@euqueroinvestir.com"]
}

variable "tags" {
  default = {
    "Squad"   = "Shared",
    "Project" = "Monitoring"
  }
}
