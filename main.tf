provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "./modules/vpc"
  project         = var.project
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  tags            = var.tags
  environment     = var.environment 
  sg_ingress_public = var.sg_ingress_public
  sg_ingress_private= var.sg_ingress_private
  sg_egress         = var.sg_egress
}
