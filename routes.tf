# Public Route Tables (one per AZ)
resource "aws_route_table" "public" {
  count  = length(aws_subnet.public) # Creates 2 route tables
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt-${count.index + 1}"
  }
}

# Private Route Tables (one per AZ)
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private) # Creates 2 route tables
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-rt-${count.index + 1}"
  }
}

# Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}