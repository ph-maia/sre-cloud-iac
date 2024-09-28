locals {
  tags_default = {
    "Environment" = terraform.workspace == "default" ? "LOCAL" : upper(terraform.workspace)
    "ManagedBy"   = "Terraform"
  }
  tags = merge(local.tags_default, {
    "Squad" = var.tags["Squad"],
    "Project" = var.tags["Project"]
  })
}