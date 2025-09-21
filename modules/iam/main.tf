# On utilise les datas pour récupérer les ressources existantes

# Groupe IAM existant
data "aws_iam_group" "ecs_deploy_group" {
  group_name = var.ecs_group_name
}

# Policies existantes
data "aws_iam_policy" "ecs_policy" {
  arn = var.ecs_policy_arn
}

data "aws_iam_policy" "iam_roles_policy" {
  arn = var.iam_roles_policy_arn
}

data "aws_iam_policy" "alb_policy" {
  arn = var.alb_policy_arn
}

data "aws_iam_policy" "ecr_policy" {
  arn = var.ecr_policy_arn
}

# Ajoute l'utilisateur existant au groupe existant
resource "aws_iam_user_group_membership" "user_membership" {
  user   = var.user_name
  groups = [data.aws_iam_group.ecs_deploy_group.name]
}
