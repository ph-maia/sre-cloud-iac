variable "aws_profile" {
  default = "default"
}
variable "aws_region" {
  default = "us-east-1"
}

variable "name" {
  default = "Limite de custo - %s USD foi atingido"
}

variable "type" {
  default = "COST"
}

variable "limit" {
  default = "5"
}

variable "threshold" {
  default = 5
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
    threshold           = 5
    threshold_type      = "ABSOLUTE_VALUE"
  }
}

variable "subscriber_email_addresses" {
  default = [
  "pedroepaola02@gmail.com"]
}

variable "tags" {
  default = {
    "Squad"   = "Shared",
    "Project" = "Monitoring"
  }
}
