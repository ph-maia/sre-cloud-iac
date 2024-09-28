variable "tags" {
  type = map(string)

  validation {
    condition = contains(keys(var.tags), "Squad") && contains(keys(var.tags), "Project")
    error_message = "Falta alguma key dentro das tags, que são obrigatórias, em caso de dúvida consulte o contrato de time AWS."
  }
}