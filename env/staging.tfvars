aws_region      = "eu-north-1"
project         = "nest-api"
vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
azs             = ["eu-north-1a", "eu-north-1b"]
environment    = "staging"
tags = {
  Environment = "staging"
}
