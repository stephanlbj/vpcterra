# Groupe IAM existant
data "aws_iam_group" "ecs_deploy_group" {
  group_name = var.ecs_group_name
}

# Ajoute l'utilisateur existant au groupe existant
resource "aws_iam_user_group_membership" "user_membership" {
  user   = var.user_name
  groups = [data.aws_iam_group.ecs_deploy_group.group_name]
}
