data "aws_availability_zones" "az" {
  state = var.state
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = map(
    "Name", "${var.tags}-eks_vpc",
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.tags}-igw"
  }
}

resource "aws_eip" "nat_eip" {
  count = length(var.public_subnet_cidr)
  vpc   = true
  tags = {
    Name = "${var.tags}-nat_eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.public_subnet_cidr)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.tags}-nat_gateway"
  }
}

resource "aws_route_table" "public_rt" {
  count  = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.main.id
  route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.tags}-public_rt"
  }
}

resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.tags}-private_rt"
  }
}

#resource "aws_route" "public_route" {
#  count                  = length(var.public_subnet_cidr)
#  route_table_id         = aws_route_table.public_rt[count.index].id
#  destination_cidr_block = "0.0.0.0/0"
#  gateway_id             = aws_internet_gateway.igw.id
#}

resource "aws_route" "private_route" {
  count                  = length(var.private_subnet_cidr)
  route_table_id         = aws_route_table.private_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index].id
}


resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr,count.index)
  availability_zone       = data.aws_availability_zones.az.names[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = map(
    "Name", "${var.tags}-public_subnet",
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_subnet" "private_subnet" {
  count              = length(var.private_subnet_cidr)
  vpc_id             = aws_vpc.main.id
  cidr_block         = element(var.private_subnet_cidr,count.index)
  availability_zone  = data.aws_availability_zones.az.names[count.index]
  tags = map(
    "Name", "${var.tags}-private_subnet",
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_subnet" "db_subnet" {
  count              = length(var.db_subnet_cidr)
  vpc_id             = aws_vpc.main.id
  cidr_block         = element(var.db_subnet_cidr,count.index)
  availability_zone  = data.aws_availability_zones.az.names[count.index]
  tags = map(
    "Name", "${var.tags}-db_subnet",
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Bastion SG"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "${var.tags}-bastion_sg"
  }
}

resource "aws_security_group_rule" "bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.localip
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.localip
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}
