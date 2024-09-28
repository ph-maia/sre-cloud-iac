# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OBRIGATÓRIAS
# ----------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "Nome do SNS Topic"
}

variable "tags" {
  type        = map(string)
  description = "Tags extras a serem adicionadas a SNS"
}

# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OPCIONAIS
# ----------------------------------------------------------------------------------------------------------------------

variable "display_name" {
  description = "Display Name do SNS Topic"
  default     = null
}

variable "delivery_policy" {
  description = "SNS delivery policy."
  default     = null
}

variable "policy" {
  description = "Policy JSON customizada para o SNS"
  default     = null
}


variable "fifo_topic" {
  description = "Boleano para definir fila como FIFO"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
 description = "Habilita a deduplicação content-based para filas FIFO"
 type = bool
 default = false
}
