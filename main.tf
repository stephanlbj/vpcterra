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
  sg_names           = var.sg_names
  sg_description     = var.sg_description
  sg_ingress_public  = var.sg_ingress_public
  sg_ingress_private = var.sg_ingress_private
  sg_egress          = var.sg_egress
}

module "ecr" {
  source = "./modules/ecr"
  repository_name = var.ecr_repository_name
}

module "ecs" {
  source      = "./modules/ecs"
  project     = var.project
  environment = var.environment
  tags        = var.tags
  vpc_id      = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets_ids
  ecs_sg_id      = module.vpc.ecs_sg_id
  alb_target_group_arn = var.alb_target_group_arn
  ecr_repository_name  = module.ecr.repository_url
}
