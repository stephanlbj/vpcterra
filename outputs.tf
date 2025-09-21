

output "cluster_id" {
  value = module.ecs.cluster_id
}

output "cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_task_execution_role_arn" {
  value = module.ecs.ecs_task_execution_role_arn
}

output "ecs_service_role_arn" {
  value = module.ecs.ecs_service_role_arn
}
