variable "region_1" {
  description = "The first AWS region"
  type        = string
}

variable "region_2" {
  description = "The second AWS region"
  type        = string
}

variable "alb_arn_region_1" {
  description = "ARN of ALB in region_1"
  type        = string
}

variable "alb_arn_region_2" {
  description = "ARN of ALB in region_2"
  type        = string
}

resource "aws_globalaccelerator_accelerator" "main" {
  name            = "my-global-accelerator"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "main" {
  accelerator_arn = aws_globalaccelerator_accelerator.main.id
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_endpoint_group" "region_1" {
  listener_arn = aws_globalaccelerator_listener.main.id
  endpoint_group_region       = var.region_1

  endpoint_configuration {
    endpoint_id                    = var.alb_arn_region_1
    weight                          = 100
    client_ip_preservation_enabled = true
  }

  health_check_protocol          = "TCP"
  health_check_port              = 80
  health_check_interval_seconds  = 30
}

resource "aws_globalaccelerator_endpoint_group" "region_2" {
  listener_arn = aws_globalaccelerator_listener.main.id
  endpoint_group_region       = var.region_2

  endpoint_configuration {
    endpoint_id                    = var.alb_arn_region_2
    weight                          = 100
    client_ip_preservation_enabled = true
  }

  health_check_protocol          = "TCP"
  health_check_port              = 80
  health_check_interval_seconds  = 30
}
