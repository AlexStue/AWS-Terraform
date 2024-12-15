
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "The CIDR block of the VPC"
  value       = aws_internet_gateway.this.id
}

output "security_group_id" {
  description = "The CIDR block of the VPC"
  value       = aws_security_group.sg.id
}
