// Variables ------------------------------------

variable "region" {
  description = "The AWS region where the ALB will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets where the ALB will be deployed"
  type        = list(string)
}

variable "private_instance_target_ips" {
  description = "The private IP addresses of the EC2 instances in private subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group for the ALB"
  type        = string
}

// Provider ------------------------------------

provider "aws" {
  region = var.region
}

// ALB ------------------------------------

resource "aws_lb" "this" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "my-alb"
  }
}

// Target Group ------------------------------------

resource "aws_lb_target_group" "this" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.this.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "my-target-group"
  }
}

// Target Group Attachments ------------------------------------

resource "aws_lb_target_group_attachment" "this" {
  for_each         = toset(var.private_instance_target_ips)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value
  port             = 80
}

// Listener ------------------------------------

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

// Outputs ------------------------------------

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}
