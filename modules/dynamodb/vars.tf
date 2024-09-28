# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OBRIGATÓRIAS
# ----------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "Nome da Tabela"
}

variable "hash_key" {}

variable "type_hash_key" {}

variable "tags" {
  description = "Tags a serem aplicadas"
  type        = map(string)
}


# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OPCIONAIS COM DEFAULT
# ----------------------------------------------------------------------------------------------------------------------

variable "sns_arn" {
  default = ""
}

variable "create_alarm" {
  type = bool
  default = false
}

variable "consumed_units_threshold" {
  default = 10
}

variable "billing_mode" {
  default = "PAY_PER_REQUEST"
}

variable "stream_enabled" {
  type = bool
  default = false
}

variable "stream_view_type" {
  default = null
}

variable "attribute_ttl" {
  default = null
}

variable "enable_ttl" {
  type = bool
  default = false
}

variable "range_key" {
  default = null
}

variable "type_range_key" {
  default = null
}

variable "read_capacity" {
  default = null
}

variable "write_capacity" {
  default = null
}

variable "global_secondary_index" {
  type = list(object({
    name = string
    write_capacity = optional(number)
    read_capacity = optional(number)
    hash_key = string
    range_key = optional(string)
    projection_type = string
    type = string
    type_range = optional(string)
    non_key_attributes = optional(list(string))
  }))

  default = null
}
