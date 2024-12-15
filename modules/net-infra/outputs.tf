
# output "internet_gateway_id" {
#   description = "The ID of the Internet Gateway"
#   value       = internet_gateway_id.this.id
# }

output "route_table_id_public" {
  description = "The ID of the Route Table"
  value       = aws_route_table.this.id
}

output "public_subnet_az1_id" {
  description = "The ID of the public subnet in AZ1"
  value       = aws_subnet.public_subnet_az1.id
}

output "nat_gateway_az1_id" {
  description = "The ID of the NAT Gateway in AZ1"
  value       = aws_nat_gateway.nat_az1.id
}

output "route_table_id_nat" {
  description = "The ID of the NAT Route Table"
  value       = aws_route_table.nat_route_table.id
}

output "private_subnet_az1_id" {
  description = "The ID of the private subnet in AZ1"
  value       = aws_subnet.private_subnet_az1.id
}
