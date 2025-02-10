
// Variables ------------------------------------

variable "region" {
  description = "The AWS region where the instance will be created"
  type        = string
}

variable "availability_zone" {
  description = "availability_zone"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet where the instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to attach to the instance"
  type        = string
}
