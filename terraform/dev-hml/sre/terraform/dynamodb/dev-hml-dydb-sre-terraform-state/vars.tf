variable "aws_profile" {}
variable "aws_region" {}

variable "name" {
  default = "dydb-terraform-state"
}

variable "hash_key" {
  default = "LockID"
}

variable "type_hash" {
  default = "S"
}

variable "tags" {
  default = {
    "Squad"   = "SRE",
    "Project" = "Ci/CD"
  }
}
