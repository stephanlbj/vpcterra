variable "ecs_group_name" {
  type        = string
  description = "Nom du groupe IAM ECS existant"
}

variable "user_name" {
  type        = string
  description = "Nom de l'utilisateur à ajouter au groupe ECS"
}
