output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private[*].id
}



output "alb_sg_id" {
  description = "Security Group de ALB"
  value       = aws_security_group.alb_sg.id
}

output "ecs_sg_id" {
  description = "Security Group des containers ECS"
  value       = aws_security_group.ecs_sg.id
}
 
