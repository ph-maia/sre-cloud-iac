locals {
  name = "[${upper(terraform.workspace)}] ${format(var.name, var.limit)}"
}