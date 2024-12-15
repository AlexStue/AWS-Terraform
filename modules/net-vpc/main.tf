
// VPC ------------------------------------

provider "aws" {
  region = var.region
}

resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "net-vpc"
  }
}

// IGW ------------------------------------

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "net-vpc-igw"
  }
}

// Security Group ------------------------------------

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.this.id
  name   = "net-vpc-sg-http"
  description = "Allow inbound HTTP traffic from any IP"

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # All protocols
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "net-vpc-sg-http"
  }
}
// ------------------------------------
