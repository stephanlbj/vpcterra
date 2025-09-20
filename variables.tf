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
