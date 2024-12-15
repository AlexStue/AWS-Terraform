/*
- Static Map for Instance IPs
- ALB
- Target Group
- Listener
*/

// Provider ------------------------------------

provider "aws" {
  region = var.region
}

// Static Map for Instance IPs ------------------------------------

locals {
  private_instance_targets = {
    for idx, ip in var.private_instance_target_ips : "instance_${idx + 1}" => ip
  }
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
  vpc_id      = var.vpc_id
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

resource "aws_lb_target_group_attachment" "this" {
  for_each         = local.private_instance_targets
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

// ------------------------------------
