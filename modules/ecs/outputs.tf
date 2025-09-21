# Outputs
output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ecs_task_execution_role_arn" {
  value = data.aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_service_role_arn" {
  value = data.aws_iam_role.ecs_service_role.arn
}
