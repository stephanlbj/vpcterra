variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "project" {
  type        = string
  description = "Nom du projet"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR du VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR pour les subnets publics"
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR pour les subnets privés"
}

variable "azs" {
  type        = list(string)
  description = "Liste des zones de disponibilité"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "environment" {
  type        = string
  description = "Nom de l'environnement (staging, preprod, prod)"
}


variable "sg_ingress_public" {
  description = "Règles ingress pour les security groups publics"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "sg_ingress_private" {
  description = "Règles ingress pour les security groups privés"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "sg_egress" {
  description = "Règles egress communes pour tous les security groups"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
