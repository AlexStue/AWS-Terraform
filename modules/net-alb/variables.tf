
// Variables ------------------------------------

variable "region" {
  description = "The AWS region where the ALB will be created"
  type        = string
}

variable "vpc_id" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group for the ALB"
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
