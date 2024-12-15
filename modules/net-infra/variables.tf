
variable "region" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "vpc_id" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "availability_zone" {
  description = "The availability zones for the VPC"
  type        = string
  default     = "eu-central-1c"
}

variable "internet_gateway_id" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "cidr_block_public" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "cidr_block_private" {
  description = "The AWS region where the VPC will be created"
  type        = string
}