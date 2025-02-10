/*
- VPC
- Infra AZ1
- Infra AZ2
- Instance AZ1
- Instance AZ2
- ALB
- GA
*/

variable "region_1" {
  description = "The AWS region where the ALB will be created"
  type        = string
  default     = "eu-central-1"
}

variable "region_2" {
  description = "The AWS region where the ALB will be created"
  type        = string
  default     = "eu-west-3"
}

// Infra for eu-central-1 ------------------------------------

module "vpc_region_1" {
  source = "../modules/net-vpc"
  region = var.region_1
}

module "infra_AZ1_region_1" {
  source = "../modules/net-infra"
  region = var.region_1
  availability_zone = "${var.region_1}a"
  cidr_block_public = "10.0.0.0/24"
  cidr_block_private = "10.0.1.0/24"
  vpc_id = module.vpc_region_1.vpc_id
  internet_gateway_id = module.vpc_region_1.internet_gateway_id
}

module "infra_AZ2_region_1" {
  source = "../modules/net-infra"
  region = var.region_1
  availability_zone = "${var.region_1}b"
  cidr_block_public = "10.0.2.0/24"
  cidr_block_private = "10.0.4.0/24"
  vpc_id = module.vpc_region_1.vpc_id
  internet_gateway_id = module.vpc_region_1.internet_gateway_id
}

module "instance_AZ1_region_1" {
  source             = "../modules/inst-1"
  region             = var.region_1
  availability_zone = "${var.region_1}a"
  private_subnet_id  = module.infra_AZ1_region_1.private_subnet_id
  security_group_id  = module.vpc_region_1.security_group_id
}

module "instance_AZ2_region_1" {
  source             = "../modules/inst-1"
  region             = var.region_1
  availability_zone = "${var.region_1}b"
  private_subnet_id  = module.infra_AZ2_region_1.private_subnet_id
  security_group_id  = module.vpc_region_1.security_group_id
}

locals {
  public_subnet_ids_region_1 = [
    module.infra_AZ1_region_1.public_subnet_id,
    module.infra_AZ2_region_1.public_subnet_id
  ]
  private_instance_target_ips_region_1 = [
    module.instance_AZ1_region_1.instance_private_ip,
    module.instance_AZ2_region_1.instance_private_ip,
  ]
}

module "alb_region_1" {
  source                 = "../modules/net-alb"
  region                 = var.region_1
  vpc_id                 = module.vpc_region_1.vpc_id
  security_group_id      = module.vpc_region_1.security_group_id
  public_subnet_ids      = local.public_subnet_ids_region_1
  private_instance_target_ips = local.private_instance_target_ips_region_1
}

// Infra for eu-west-3 ------------------------------------

module "vpc_region_2" {
  source = "../modules/net-vpc"
  region = var.region_2
}

module "infra_AZ1_region_2" {
  source = "../modules/net-infra"
  region = var.region_2
  availability_zone = "${var.region_2}a"
  cidr_block_public = "10.0.0.0/24"
  cidr_block_private = "10.0.1.0/24"
  vpc_id = module.vpc_region_2.vpc_id
  internet_gateway_id = module.vpc_region_2.internet_gateway_id
}

module "infra_AZ2_region_2" {
  source = "../modules/net-infra"
  region = var.region_2
  availability_zone = "${var.region_2}b"
  cidr_block_public = "10.0.2.0/24"
  cidr_block_private = "10.0.3.0/24"
  vpc_id = module.vpc_region_2.vpc_id
  internet_gateway_id = module.vpc_region_2.internet_gateway_id
}

module "instance_AZ1_region_2" {
  source             = "../modules/inst-1"
  region             = var.region_2
  availability_zone = "${var.region_2}a"
  private_subnet_id  = module.infra_AZ1_region_2.private_subnet_id
  security_group_id  = module.vpc_region_2.security_group_id
}

module "instance_AZ2_region_2" {
  source             = "../modules/inst-1"
  region             = var.region_2
  availability_zone = "${var.region_2}b"
  private_subnet_id  = module.infra_AZ2_region_2.private_subnet_id
  security_group_id  = module.vpc_region_2.security_group_id
}

locals {
  public_subnet_ids_region_2 = [
    module.infra_AZ1_region_2.public_subnet_id,
    module.infra_AZ2_region_2.public_subnet_id
  ]
  private_instance_target_ips_region_2 = [
    module.instance_AZ1_region_2.instance_private_ip,
    module.instance_AZ2_region_2.instance_private_ip,
  ]
}

module "alb_region_2" {
  source                 = "../modules/net-alb"
  region                 = var.region_2
  vpc_id                 = module.vpc_region_2.vpc_id
  security_group_id      = module.vpc_region_2.security_group_id
  public_subnet_ids      = local.public_subnet_ids_region_2
  private_instance_target_ips = local.private_instance_target_ips_region_2
}

// GlobeAccl ------------------------------------

module "global_accelerator" {
  source   = "../modules/global-accel"
  region_1 = var.region_1
  region_2 = var.region_2

  alb_arn_region_1 = module.alb_region_1.alb_arn
  alb_arn_region_2 = module.alb_region_2.alb_arn
}

// EFS ------------------------------------

// Databases ------------------------------------
