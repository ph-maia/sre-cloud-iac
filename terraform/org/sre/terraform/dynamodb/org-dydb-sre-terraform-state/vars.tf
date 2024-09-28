variable "aws_profile" {
  default = "org"
}

variable "name" {
  default = "dydb-sre-terraform-state"
}

variable "hash_key" {
  default = "LockID"
}

variable "type_hash" {
  default = "S"
}

variable "tags" {
  default = {
    "Squad" = "SRE",
    "Project" = "Terraform"
  }
}