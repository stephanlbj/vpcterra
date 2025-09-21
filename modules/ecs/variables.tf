variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "alb_target_group_arn" {
  type = string
}

 
variable "ecr_repository_name" {
  type        = string
  description = "Nom du repository ECR"
}