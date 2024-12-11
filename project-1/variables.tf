variable "region" {
  description = "AWS region"
  type        = string
}

variable "public_subnet_configs" {
  description = "List of public subnet configurations"
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "regions" {
  description = "List of regions for Global Accelerator"
  type        = list(string)
}
