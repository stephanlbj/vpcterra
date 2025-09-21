variable "user_name" {
  type        = string
  description = "Nom de l'utilisateur IAM existant"
}

variable "ecs_group_name" {
  type        = string
  description = "Nom du groupe IAM ECS / déploiement existant"
}

variable "ecs_policy_arn" {
  type        = string
  description = "ARN de la policy ECS / Fargate existante"
}

variable "iam_roles_policy_arn" {
  type        = string
  description = "ARN de la policy IAM roles existante"
}

variable "alb_policy_arn" {
  type        = string
  description = "ARN de la policy ALB existante"
}

variable "ecr_policy_arn" {
  type        = string
  description = "ARN de la policy ECR existante"
}
