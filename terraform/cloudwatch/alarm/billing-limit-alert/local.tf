locals {
  name = format(var.name, var.limit)
  # name = "[${upper(terraform.workspace)}] ${format(var.name, var.limit)}"
}
