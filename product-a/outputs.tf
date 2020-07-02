output "vpc_id" {
  value = aws_vpc.main.id
}
output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}
output "private_subnet_ip" {
  value = aws_subnet.private_subnet.*.cidr_block
}
