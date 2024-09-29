variable "aws_profile" {}
variable "aws_region" {}

variable "name" {
  default = "s3-sre-terraform-state"
}

variable "tags" {
  default = {
    "Squad"   = "SRE",
    "Project" = "CI/CD"
  }
}
