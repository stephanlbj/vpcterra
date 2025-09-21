resource "aws_ecr_repository" "app" {
  name                 = var.ecr_repository_name != null ? var.ecr_repository_name : "${var.project}-${var.environment}-repo"
  image_tag_mutability = "MUTABLE"
  tags                 = merge(var.tags, 
  { 
  Environment = var.environment
   }
   )
}


