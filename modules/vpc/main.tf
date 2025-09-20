# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, { Name = "${var.project}-vpc" })
}

# Subnets publics
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "${var.project}-public-${count.index + 1}" })
}

# Subnets privés
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, { Name = "${var.project}-private-${count.index + 1}" })
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { Name = "${var.project}-${var.environment}-igw" })
}

# Route Table pour subnets publics
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { Name = "${var.project}-${var.environment}-public-rt" })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = { for idx, subnet in aws_subnet.public : idx => subnet.id }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# Elastic IP pour NAT
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(var.tags, { Name = "${var.project}-${var.environment}-eip-nat" })
}

# NAT Gateway
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(var.tags, { Name = "${var.project}-${var.environment}-nat" })
}

# Route Table pour subnets privés
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { Name = "${var.project}-${var.environment}-private-rt" })
}

resource "aws_route" "private_outbound" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "private" {
  for_each = { for idx, subnet in aws_subnet.private : idx => subnet.id }

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}

# Security Groups
resource "aws_security_group" "alb_sg" {
  name        = "${var.project}-${var.environment}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.this.id
  tags        = merge(var.tags, { Environment = var.environment })
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.project}-${var.environment}-ecs-sg"
  description = "ECS containers Security Group"
  vpc_id      = aws_vpc.this.id
  tags        = merge(var.tags, { Environment = var.environment })
}

# Ingress rules
resource "aws_security_group_rule" "alb_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "ecs_ingress" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]  # VPC CIDR
  security_group_id = aws_security_group.ecs_sg.id
}

# Egress rules (tout sortir)
resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "ecs_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}
