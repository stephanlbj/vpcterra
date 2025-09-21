variable "project" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "sg_names" {
  description = "Names of the Security Groups to create"
  type        = list(string)
  default     = ["alb-sg", "ecs-sg"]
}

variable "sg_description" {
  description = "Descriptions of the Security Groups (ASCII only)"
  type        = list(string)
  default     = ["Security Group for the ALB", "Security Group for ECS containers"]
}

variable "sg_ingress_public" {
  description = "Ingress rules for public Security Groups (ALB)"
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
  description = "Common egress rules for all Security Groups"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
