# Groupe IAM pour ECS / déploiement
resource "aws_iam_group" "ecs_deploy_group" {
  name = "${var.project_prefix}-ecs-deploy-group"
}

# Ajoute l'utilisateur au groupe
resource "aws_iam_user_group_membership" "user_membership" {
  user   = var.user_name
  groups = [aws_iam_group.ecs_deploy_group.name]
}

# 1️⃣ ECS & Fargate permissions
resource "aws_iam_policy" "ecs_policy" {
  name        = "${var.project_prefix}-ecs-fargate-policy"
  description = "Permissions ECS et PassRole pour Fargate"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["ecs:*", "iam:PassRole"],
        Resource = "*"
      }
    ]
  })
}

# 2️⃣ IAM role creation permissions
resource "aws_iam_policy" "iam_roles_policy" {
  name        = "${var.project_prefix}-iam-roles-policy"
  description = "Permet de créer et attacher des roles IAM pour le projet ${var.project_prefix}"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "iam:CreateRole",
          "iam:AttachRolePolicy",
          "iam:GetRole",
          "iam:ListAttachedRolePolicies"
        ],
        Resource = "arn:aws:iam::*:role/${var.project_prefix}-*"
      }
    ]
  })
}

# 3️⃣ ALB / ELB permissions
resource "aws_iam_policy" "alb_policy" {
  name        = "${var.project_prefix}-alb-policy"
  description = "Permissions pour créer et gérer Application Load Balancer"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "elasticloadbalancing:*",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs"
        ],
        Resource = "*"
      }
    ]
  })
}

# 4️⃣ ECR permissions
resource "aws_iam_policy" "ecr_policy" {
  name        = "${var.project_prefix}-ecr-read-policy"
  description = "Permet ECS de récupérer les images depuis ECR"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attache toutes les policies au groupe
resource "aws_iam_group_policy_attachment" "ecs_attach" {
  for_each = {
    ecs  = aws_iam_policy.ecs_policy.arn
    iam  = aws_iam_policy.iam_roles_policy.arn
    alb  = aws_iam_policy.alb_policy.arn
    ecr  = aws_iam_policy.ecr_policy.arn
  }

  group      = aws_iam_group.ecs_deploy_group.name
  policy_arn = each.value
}


