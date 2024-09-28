terraform {
  required_version = ">=1.1.5"

  experiments = [module_variable_optional_attrs]

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.20.0"
    }
  }
}