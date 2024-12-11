resource "aws_lb" "alb" {
  name               = "ALB-${var.region}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = aws_subnet.public[*].id

  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "tg" {
  name     = "TargetGroup-${var.region}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
