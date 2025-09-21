aws_region      = "eu-north-1"
project         = "nest-api"
vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
azs             = ["eu-north-1a", "eu-north-1b"]
user_name             = "Stephan"
ecs_group_name        = "nest-api-ecs-deploy-group"
ecs_policy_arn        = "arn:aws:iam::123456789012:policy/nest-api-ecs-fargate-policy"
iam_roles_policy_arn  = "arn:aws:iam::123456789012:policy/nest-api-iam-roles-policy"
alb_policy_arn        = "arn:aws:iam::123456789012:policy/nest-api-alb-policy"
ecr_policy_arn        = "arn:aws:iam::123456789012:policy/nest-api-ecr-read-policy"

 

sg_ingress_private = [
  { from_port = 3000, to_port = 3000, protocol = "tcp", source_security_group = "alb_sg" }
]

sg_ingress_public = [
  { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
]

sg_egress = [
  { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
]



environment    = "staging"
tags = {
  Environment = "staging"
}
