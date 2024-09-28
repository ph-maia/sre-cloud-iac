variable "aws_profile" {
  default = "org"
}

variable "name" {
  default = "s3-sre-terraform-state"
}

variable "tags" {
  default = {
    "Squad" = "SRE",
    "Project" = "Terraform"
  }
}