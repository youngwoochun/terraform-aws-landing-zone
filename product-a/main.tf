provider "aws" {
  region = var.region
}
module "network" {
  source                  = "../network"
  localip                 = var.localip
  vpc_cidr                = var.vpc_cidr
  enable_dns_support      = var.vpc_dns_support
  enable_dns_hostnames    = var.vpc_dns_hostnames
  public_subnet_cidr      = var.public_subnet_cidr
  private_subnet_cidr     = var.private_subnet_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  state                   = var.state
  tags                    = var.tags
  cluster_name            = var.cluster_name
}

module "bastion" {
  source                      = "../ec2"
  instance_count              = var.bastion_instance_defaults["instance_count"]
  ami                         = var.bastion_instance_defaults["ami"]
  instance_type               = var.bastion_instance_defaults["instance_type"]
  user_data                   = var.bastion_instance_defaults["user_data"]
  subnet_id                   = module.network.public_subnets
  key_name                    = var.bastion_instance_defaults["key_name"]
  monitoring                  = var.bastion_instance_defaults["monitoring"]
  vpc_security_group_ids      = module.network.bastion_security_group_id
  iam_instance_profile        = var.bastion_instance_defaults["iam_instance_profile"]
  associate_public_ip_address = var.bastion_instance_defaults["associate_public_ip_address"]
  ebs_optimized               = var.bastion_instance_defaults["ebs_optimized"]
  tags                        = var.tags
}
