variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block du VPC"
  type        = string
}

variable "public_subnets" {
  description = "Liste des subnets publics"
  type        = list(string)
}

variable "private_subnets" {
  description = "Liste des subnets privés"
  type        = list(string)
}

variable "azs" {
  description = "Zones de disponibilité"
  type        = list(string)
}

variable "tags" {
  description = "Tags communs"
  type        = map(string)
  default     = {}
}
