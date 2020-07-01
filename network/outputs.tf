output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

output "public_subnet_ip" {
  value = aws_subnet.public_subnet.*.cidr_block
}

output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}

output "private_subnet_ip" {
  value = aws_subnet.private_subnet.*.cidr_block
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_sg.*.id
}
