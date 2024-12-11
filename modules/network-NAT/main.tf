resource "aws_nat_gateway" "nat" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  allocation_id = aws_eip.nat_eip[count.index].id
  tags = {
    Name = "PublicNatGateway-${var.region}-Nr${count.index + 1}"
  }
}

resource "aws_eip" "nat_eip" {
  count = length(aws_subnet.public)
}
