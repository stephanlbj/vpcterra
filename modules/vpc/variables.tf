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


variable "environment" {
  description = "Environnement (ex: dev, staging, prod)"
  type        = string
}

variable "sg_names" {
  description = "Liste des noms de Security Groups à créer"
  type        = list(string)
  default     = ["app-sg", "db-sg"]
}

variable "sg_description" {
  description = "Descriptions des Security Groups correspondants"
  type        = list(string)
  default     = ["Security Group pour l'application", "Security Group pour la base de données"]
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


