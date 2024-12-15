/*
- VPC
- Infra AZ1
- Infra AZ2
- Instance AZ1
- Instance AZ2
- ALB
- 
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
  availability_zone = "eu-central-1a"
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

// Instances ------------------------------------

module "instance-AZ1" {
  source             = "../modules/inst-1"
  region             = "eu-central-1"
  private_subnet_id  = module.infra-AZ1.private_subnet_id
  security_group_id  = module.vpc.security_group_id
}

module "instance-AZ2" {
  source             = "../modules/inst-1"
  region             = "eu-central-1"
  private_subnet_id  = module.infra-AZ2.private_subnet_id
  security_group_id  = module.vpc.security_group_id
}

// ALB ------------------------------------

locals {
  public_subnet_ids = [
    module.infra-AZ1.public_subnet_id,
    module.infra-AZ2.public_subnet_id
  ]
  private_instance_target_ips = [
    module.instance-AZ1.instance_private_ip,
    module.instance-AZ2.instance_private_ip,
  ]
}

module "alb" {
  source                 = "../modules/net-alb"
  region                 = "eu-central-1"
  vpc_id = module.vpc.vpc_id
  security_group_id      = module.vpc.security_group_id
  public_subnet_ids      = local.public_subnet_ids
  private_instance_target_ips = [
    module.instance-AZ1.instance_private_ip,
    module.instance-AZ2.instance_private_ip
  ]
}

// GlobeAccl ------------------------------------



// EFS ------------------------------------



// Databases ------------------------------------

