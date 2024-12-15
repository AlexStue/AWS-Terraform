/*

*/

// VPC ------------------------------------

module "vpc" {
  source = "../modules/net-vpc"
  region = "eu-central-1"
}

// Infra ------------------------------------

module "infra-AZ1" {
  source = "../modules/net-infra"
  region = "eu-central-1"
  availability_zone = "eu-central-1b"
  cidr_block_public = "10.0.1.0/24"
  cidr_block_private = "10.0.2.0/24"
  vpc_id = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
}

module "infra-AZ2" {
  source = "../modules/net-infra"
  region = "eu-central-1"
  availability_zone = "eu-central-1b"
  cidr_block_public = "10.0.3.0/24"
  cidr_block_private = "10.0.4.0/24"
  vpc_id = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
}

// Insgtances ------------------------------------

module "instance-AZ1" {
  source             = "../modules/inst-1"
  region             = "eu-central-1"
  private_subnet_id  = module.infra-AZ1.private_subnet_az1_id
  security_group_id  = module.vpc.security_group_id
}

// ALB ------------------------------------

module "alb" {
  source                 = "../modules/alb"
  region                 = "eu-central-1"
  public_subnet_ids      = module.vpc.public_subnet_ids
  private_instance_target_ips = module.instance.instance_private_ips
  security_group_id      = module.vpc.security_group_id
}

// GlobeAccl ------------------------------------



// EFS ------------------------------------



// Databases ------------------------------------



// Insgtances ------------------------------------



