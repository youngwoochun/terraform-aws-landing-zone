localip                 = ["73.126.78.8/32"]
vpc_cidr                = "10.123.0.0/16"
vpc_dns_support         = true
vpc_dns_hostnames       = true
public_subnet_cidr      = ["10.123.1.0/24", "10.123.2.0/24"]
private_subnet_cidr     = ["10.123.11.0/24", "10.123.12.0/24"]
map_public_ip_on_launch = true
state                   = "available"
