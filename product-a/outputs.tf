output "vpc_id" {
  value = module.network.vpc_id
}
output "private_subnets" {
  value = module.network.public_subnets.*.id
}
