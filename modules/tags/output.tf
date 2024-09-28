output "tags" {
  value = local.tags
}

output "tags_OnOff" {
  value = merge(local.tags, {
     "OnOff"       = true
  })
}