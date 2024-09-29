variable "aws_profile" {
  default = "default"
}

variable "name" {
  default = "s3-terraform-state-sre"
}

variable "tags" {
  default = {
    "Squad"   = "SRE",
    "Project" = "Terraform"
  }
}
