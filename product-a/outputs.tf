output "vpc_id" {
  value = module.network.vpc_id
}
output "private_subnets" {
  value = module.network.private_subnet_cidr.*.id
}
