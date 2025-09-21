output "ecs_deploy_group_name" {
  value = aws_iam_group.ecs_deploy_group.name
}

output "attached_policies" {
  value = [
    aws_iam_policy.ecs_policy.arn,
    aws_iam_policy.iam_roles_policy.arn,
    aws_iam_policy.alb_policy.arn,
    aws_iam_policy.ecr_policy.arn
  ]
}
