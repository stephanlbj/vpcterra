resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    { Name = "${var.project}-vpc" }
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { Name = "${var.project}-public-${count.index + 1}" }
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = merge(
    var.tags,
    { Name = "${var.project}-private-${count.index + 1}" }
  )
}


# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-igw"
  })
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-public-rt"
  })
}

# Route: all traffic goes to IGW
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Associate route table with public subnets
resource "aws_route_table_association" "public" {
  for_each = { for idx, subnet in aws_subnet.public : idx => subnet.id }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# Elastic IP for NAT
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-eip-nat"
  })
}

# NAT Gateway (dans le premier subnet public)
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-nat"
  })
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-private-rt"
  })
}

# Route: all traffic from private subnets -> NAT
resource "aws_route" "private_outbound" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

# Associate route table with private subnets
resource "aws_route_table_association" "private" {
  for_each = { for idx, subnet in aws_subnet.private : idx => subnet.id }

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}

# Security Groups
resource "aws_security_group" "sg" {
  for_each = { for idx, name in var.sg_names : idx => name }

  name        = each.value
  description = var.sg_description[each.key]
  vpc_id      = aws_vpc.this.id
  tags        = merge(var.tags, { Name = "${var.project}-${each.value}" })
}

# Ingress rules
resource "aws_security_group_rule" "ingress" {
  for_each = { for idx, sg in aws_security_group.sg : idx => sg }

  type              = "ingress"
  from_port         = var.sg_ingress[each.key].from_port
  to_port           = var.sg_ingress[each.key].to_port
  protocol          = var.sg_ingress[each.key].protocol
  cidr_blocks       = var.sg_ingress[each.key].cidr_blocks
  security_group_id = each.value.id
}

# Egress rules
resource "aws_security_group_rule" "egress" {
  for_each = { for idx, sg in aws_security_group.sg : idx => sg }

  type              = "egress"
  from_port         = var.sg_egress[each.key].from_port
  to_port           = var.sg_egress[each.key].to_port
  protocol          = var.sg_egress[each.key].protocol
  cidr_blocks       = var.sg_egress[each.key].cidr_blocks
  security_group_id = each.value.id
}



