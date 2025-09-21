variable "aws_region" { type = string }
variable "project" { type = string }
variable "environment" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "azs" { type = list(string) }
variable "tags" { type = map(string) }
variable "sg_names" { type = list(string) }
variable "sg_description" { type = list(string) }
variable "sg_ingress_public" { type = list(object({ from_port:number, to_port:number, protocol:string, cidr_blocks:list(string) })) }
variable "sg_ingress_private" { type = list(object({ from_port:number, to_port:number, protocol:string, cidr_blocks?:list(string), source_security_group_id?:string })) }
variable "sg_egress" { type = list(object({ from_port:number, to_port:number, protocol:string, cidr_blocks:list(string) })) }

# ECR
variable "ecr_repository_name" { type = string }

# ALB
variable "alb_target_group_arn" { type = string }
