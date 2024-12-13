
module "vpc" {
  source = "../modules/net-vpc"
  region   = "eu-central-1"
  vpc_cidr = "10.0.0.0/16"
}

output "project_vpc_id" {
  description = "The ID of the VPC for the project"
  value       = module.vpc.vpc_id
}

output "project_vpc_cidr" {
  description = "The CIDR block of the VPC for the project"
  value       = module.vpc.vpc_cidr
}
