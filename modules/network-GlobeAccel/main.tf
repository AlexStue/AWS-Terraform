resource "aws_globalaccelerator_accelerator" "accelerator" {
  name               = "MyMultiRegionAccelerator"
  ip_address_type    = "IPV4"
}

resource "aws_globalaccelerator_listener" "listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.accelerator.arn
  port_ranges = [
    {
      from_port = 80
    },
    {
      from_port = 443
    }
  ]
}

resource "aws_globalaccelerator_endpoint_group" "endpoint_group" {
  count                = length(var.regions)
  listener_arn         = aws_globalaccelerator_listener.listener.arn
  endpoint_group_region = var.regions[count.index]

  endpoint_configuration {
    endpoint_id        = aws_lb.alb.arn
    weight             = 100
    client_ip_preservation_enabled = true
  }
}
