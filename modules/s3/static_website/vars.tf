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


variable "index_document" {
  default = "index.html"
}

variable "error_document" {
  default = null
}

variable "routing_rules" {
  default = null
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