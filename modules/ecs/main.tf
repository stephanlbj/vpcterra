resource "aws_ecs_cluster" "this" {
  name = "${var.project}-${var.environment}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(var.tags, {
    Name        = "${var.project}-${var.environment}-cluster"
    Environment = var.environment
  })
}

# Référence du rôle ECS Task Execution existant
data "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project}-${var.environment}-ecs-task-execution-role"
}

# Référence du rôle ECS Service existant
data "aws_iam_role" "ecs_service_role" {
  name = "${var.project}-${var.environment}-ecs-service-role"
}