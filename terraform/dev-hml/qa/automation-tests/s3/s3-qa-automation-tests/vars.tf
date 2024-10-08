variable "aws_profile" {}
variable "aws_region" {}

variable "name" {
  default = "s3-qa-automation-tests"
}

variable "tags" {
  default = {
    "Squad"   = "QA",
    "Project" = "Automation-Tests"
  }
}
