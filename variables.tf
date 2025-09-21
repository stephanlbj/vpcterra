variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDRs for public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDRs for private subnets"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "environment" {
  type        = string
  description = "Environment name (staging, preprod, prod)"
}

variable "sg_names" {
  description = "List of Security Group names to create"
  type        = list(string)
  default     = ["alb-sg", "ecs-sg"]
}

variable "sg_description" {
  description = "Descriptions of Security Groups (ASCII only)"
  type        = list(string)
  default     = ["Security Group for ALB", "Security Group for ECS containers"]
}

variable "sg_ingress_public" {
  description = "Ingress rules for public security groups (ALB)"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "sg_ingress_private" {
  description = "Ingress rules for private security groups"
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
}


variable "sg_egress" {
  description = "Common egress rules for all security groups"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# Variables pour IAM existant
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
