
#-----------------------------

provider "aws" {
  region = var.region
}

#-----------------------------

module "vpc" {
  for_each = toset(var.regions)
  source   = "./modules/vpc"
  region   = each.key
}

module "security_group" {
  for_each = toset(var.regions)
  source   = "./modules/security_group"
  region   = each.key
  vpc_id   = module.vpc[each.key].vpc_id  # Pass the VPC ID from the VPC module
}

/*
module "nat_gateway" {
  for_each = toset(var.regions)
  source   = "./modules/nat_gateway"
  region   = each.key
}

module "load_balancer" {
  for_each = toset(var.regions)
  source   = "./modules/load_balancer"
  region   = each.key
}

module "ec2_instance" {
  for_each = toset(var.regions)
  source   = "./modules/ec2_instance"
  region   = each.key
}

module "global_accelerator" {
  source = "./modules/global_accelerator"
  region = "us-west-2"  # Global Accelerator is always in one region
}

*/

#-----------------------------
