variable "ecs_group_name" {
  type        = string
  description = "Nom du groupe IAM ECS existant"
}

variable "ecs_policy_arn" {
  type        = string
  description = "ARN de la policy ECS existante"
}

variable "iam_roles_policy_arn" {
  type        = string
  description = "ARN de la policy IAM Roles existante"
}

variable "alb_policy_arn" {
  type        = string
  description = "ARN de la policy ALB existante"
}

variable "ecr_policy_arn" {
  type        = string
  description = "ARN de la policy ECR existante"
}

variable "user_name" {
  type        = string
  description = "Nom de l'utilisateur à ajouter au groupe ECS"
}
