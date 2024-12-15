
// Outputs of VPC ------------------------------------

output "project_vpc_id" {
  description = "The ID of the VPC for the project"
  value       = module.vpc.vpc_id
}

output "project_vpc_cidr" {
  description = "The CIDR block of the VPC for the project"
  value       = module.vpc.vpc_cidr
}

// IGW

output "project_internet_gateway_id" {
  description = "The ID of the Internet Gateway for the project"
  value       = module.vpc.internet_gateway_id
}

// Route Table

output "project_route_table_id_public" {
  description = "The ID of the Route Table for the project"
  value       = module.infra-AZ1.route_table_id_public
}

// Security Group

output "project_security_group_id" {
  description = "The ID of the Security Group for HTTP traffic"
  value       = module.vpc.security_group_id
}

// Subnet Public AZ1

output "project_public_subnet_id" {
  description = "The ID of the public subnet in AZ1"
  value       = module.infra-AZ1.public_subnet_id
}

output "project_public_subnet_id_AZ1" {
  description = "The ID of the private subnet in AZ1"
  value       = module.infra-AZ1.public_subnet_id
}

output "project_public_subnet_id_AZ2" {
  description = "The ID of the private subnet in AZ1"
  value       = module.infra-AZ1.public_subnet_id
}

// NAT Gateway AZ1

output "project_nat_gateway_id" {
  description = "The ID of the NAT Gateway in AZ1"
  value       = module.infra-AZ1.nat_gateway_id
}

// Route Table - NAT

output "project_route_table_id_nat" {
  description = "The ID of the NAT Route Table for the project"
  value       = module.infra-AZ1.route_table_id_nat
}

// Outputs of Instance ------------------------------------

output "project_instance_id" {
  description = "The ID of the EC2 instance for the project"
  value       = module.instance-AZ1.instance_id
}

output "project_instance_private_ip_AZ1" {
  description = "The private IP address of the EC2 instance for the project"
  value       = module.instance-AZ1.instance_private_ip
}

output "project_instance_arn" {
  description = "The ARN of the EC2 instance for the project"
  value       = module.instance-AZ1.instance_arn
}

output "project_instance_availability_zone" {
  description = "The availability zone of the EC2 instance for the project"
  value       = module.instance-AZ1.instance_availability_zone
}
