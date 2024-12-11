
#-----------------------------

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "public_subnet_configs" {
  description = "--"
  type        = string
}

#-----------------------------

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Vpc-ProjectOne-${var.region}"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_configs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.public_subnet_configs, count.index)["cidr_block"]
  availability_zone = element(var.public_subnet_configs, count.index)["availability_zone"]
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet-${var.region}-Nr${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "InternetGateway-${var.region}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "PublicRouteTable-${var.region}-toIGN"
  }
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gateway.id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#-----------------------------

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.vpc.id
}

#-----------------------------
