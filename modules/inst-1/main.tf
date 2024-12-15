// Variables ------------------------------------

variable "region" {
  description = "The AWS region where the instance will be created"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet where the instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to attach to the instance"
  type        = string
}

provider "aws" {
  region = var.region
}

// EC2 Instance ------------------------------------

resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = var.private_subnet_id
  key_name                    = "key-aws-1"
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.security_group_id]

  root_block_device {
    volume_size = 20 # Size in GB
    volume_type = "gp2"
  }

  tags = {
    Name = "privateinstance-az1-nr1"
  }
}

// Data source for Amazon Linux AMI ------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"] # Amazon-owned AMIs
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

// Outputs ------------------------------------

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.this.arn
}

output "instance_availability_zone" {
  description = "The availability zone of the EC2 instance"
  value       = aws_instance.this.availability_zone
}
