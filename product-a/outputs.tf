output "vpc_id" {
  value = module.network.vpc_id
}

output "private_subnet_id" {
  value = module.network.private_subnets
}
