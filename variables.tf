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
  description = "CIDR of the VPC"
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
  default     = ["app-sg", "db-sg"]
}

variable "sg_description" {
  description = "Descriptions of Security Groups"
  type        = list(string)
  default     = ["Security Group for application", "Security Group for database"]
}

variable "sg_ingress_public" {
  description = "Ingress rules for public security groups"
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
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
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
