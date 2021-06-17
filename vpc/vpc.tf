# --- MAIN VPC ---
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Main VPC"
  }
}

# --- SUBNETS ---
# Subnet: public
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "Public subnet"
  }
}

# Subnet: private
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "Private Subnet"
  }
}

# Subnet: data
resource "aws_subnet" "data_zone_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.data_subnet_cidr[0]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "Data Subnet zone 1"
  }
}
resource "aws_subnet" "data_zone_2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.data_subnet_cidr[1]
  availability_zone = var.availability_zone[1]
  tags = {
    Name = "Data Subnet zone 2"
  }
}
resource "aws_db_subnet_group" "this" {
  subnet_ids = [aws_subnet.data_zone_2.id, aws_subnet.data_zone_1.id]
  tags = {
    Name = "RDS data Subnet"
  }
}

# --- INTERNET GATEWAY ---
# Internet gateway: An internet gateway must be attached to the VPC so the public resources are accessible from internet
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Internet Gateway"
  }
}
resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "Public Subnet Route Table"
  }
}
resource "aws_route_table_association" "public_subnet_internet_gateway" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_subnet.id
}

# --- NAT GATEWAY ---
# NAT gateway : A NAT gateway is attached to the public subnet so the private resources can access internet (updates, software installation...)
# The NAT Gateway is created in the public subnet with an associated elastic IP address
resource "aws_eip" "nat_gw" {
  vpc = true
}
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "NAT Gateway"
  }
}
resource "aws_route_table" "private_subnet" {
  vpc_id   = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "Private Subnet Route Table"
  }
}
resource "aws_route_table_association" "private_subnet_nat_gateway" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_subnet.id
}