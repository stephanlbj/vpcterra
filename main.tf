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

  # Security Groups
  sg_names           = var.sg_names
  sg_description     = var.sg_description
  sg_ingress_public  = var.sg_ingress_public   # pour ALB
  sg_ingress_private = var.sg_ingress_private  # pour ECS containers
  sg_egress          = var.sg_egress
}

module "ec2" {
  source         = "./modules/ec2"
  project        = var.project
  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets_ids
  alb_sg_id      = module.vpc.alb_sg_id
}

module "ecs" {
  source      = "./modules/ecs"
  project     = var.project
  environment = var.environment
  tags        = var.tags
}

module "iam" {
  source         = "./modules/iam"
  user_name      = var.user_name        # injecté depuis staging.tfvars
  project_prefix = var.project_prefix   # injecté depuis staging.tfvars
}

