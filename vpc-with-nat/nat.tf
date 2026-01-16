# ============================================
# NAT Gateway Configuration
# ============================================

# Elastic IP for NAT Gateway - Static IP for outbound traffic
resource "aws_eip" "nat" {
  domain = "vpc"

  # Ensure IGW exists before creating EIP
  depends_on = [aws_internet_gateway.main]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-nat-eip"
    }
  )
}

# NAT Gateway - Enables private subnet instances to access internet
# Placed in first public subnet for outbound connectivity
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.main]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-nat-gw"
    }
  )
}

# ============================================
# Private Route Table - Routes traffic to NAT
# ============================================

# Route table for private subnets - directs internet traffic through NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-private-rt"
    }
  )
}

# ============================================
# Private Route Table Associations
# ============================================

# Associate private subnets with private route table
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
