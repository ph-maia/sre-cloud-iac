variable "name_bucket" {
  type    = string
}

variable "acl" {
  type    = string
  default = "private"
}

variable "tags" {
  type    = map(string)
}

variable "force_destroy" {
  type    = bool
  default = true
}

variable "versioning" {
  type    = bool
  default = false
}

variable "lifecycle_rule" {

  type = list(object({
    id = string
    prefix = optional(string)
    enabled = bool
  }))

  default = null

}

variable "expiration_lifecycle" {

  type = map(object({
    date = optional(string)
    days = optional(number)
    expired_object_delete_marker = optional(string)
  }))

  default = {}

}

variable "policy" {
  default = null
}

variable "transition_lifecycle" {

  type = map(object({
    date = optional(string)
    days = optional(number)
    storage_class = string
  }))

  default = {}

}

variable "noncurrent_version_expiration_lifecycle" {

  type = map(object({
    days = optional(number)
  }))

  default = {}

}

variable "noncurrent_version_transition_lifecycle" {

  type = map(object({
    days = optional(number)
    storage_class = string
  }))

  default = {}

}

variable "cors_rule" {

  type = list(object({
    allowed_headers = optional(string)
    allowed_methods = optional(list(string))
    allowed_origins = optional(list(string))
    expose_headers  = optional(list(string))
    max_age_seconds = optional(number)
  }))

  default = null

}