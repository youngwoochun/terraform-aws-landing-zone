variable "region" {
  type = string
}
variable "tags" {
  type = string
}
variable "localip" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "vpc_dns_support" {
  type = bool
}
variable "vpc_dns_hostnames" {
  type = bool
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnet_cidr" {
  type = list(string)
}
variable "private_subnet_cidr" {
  type = list(string)
}
variable "map_public_ip_on_launch" {
  type = bool
}
variable "state" {
  type = string
}
variable "bastion_instance_defaults" {
  type = map(any)
}
