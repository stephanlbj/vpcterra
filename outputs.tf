output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets_ids
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets_ids
}

output "ecr_url" {
  value = module.ecr.ecr_url
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}

output "ecs_task_definition_arn" {
  value = module.ecs.ecs_task_definition_arn
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}