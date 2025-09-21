variable "user_name" {
  type        = string
  description = "Nom de l'utilisateur IAM à qui on attribue les permissions"
}

variable "project_prefix" {
  type        = string
  description = "Préfixe utilisé pour nommer les rôles et policies pour ce projet"
}
