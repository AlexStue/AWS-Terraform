/*
- Route Table to IGW
- Subnet public
- NAT Gateway
- Route Table to NAT Gateway
- Subnet private
*/

provider "aws" {
  region = var.region
}

// Route Table to IGW ------------------------------------

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags = {
    Name = "net-vpc-routetable_public"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

// Subnet public ------------------------------------

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_public
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "net-vpc-public-subnet-az1"
  }
}

resource "aws_route_table_association" "public_subnet_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.this.id
}

// NAT Gateway ------------------------------------

resource "aws_eip" "nat_eip_az1" {
  //vpc = true
  tags = {
    Name = "net-vpc-nat-eip-az1"
  }
}

resource "aws_nat_gateway" "nat_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id
  tags = {
    Name = "net-vpc-nat-gw-az1"
  }
}

// Route Table to NAT Gateway ------------------------------------

resource "aws_route_table" "nat_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "net-vpc-routetable_nat"
  }
}

resource "aws_route" "nat_route" {
  route_table_id         = aws_route_table.nat_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_az1.id
}

// Subnet private ------------------------------------

resource "aws_subnet" "private_subnet_az1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "net-vpc-private-subnet-az1"
  }
}

resource "aws_route_table_association" "private_subnet_az1" {
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.nat_route_table.id
}

// ------------------------------------
