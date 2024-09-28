locals {
  keys_indexes = var.global_secondary_index == null ? [] : [for value in var.global_secondary_index : value if value["range_key"] != null]
}
