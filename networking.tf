resource "aws_vpc" "vpc_tp" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name        = "vpc_tp"
    Terraform   = "True"
    Description = "VPC for the web application"
  }
}

resource "aws_subnet" "subnet_public_one" {
  vpc_id                  = aws_vpc.vpc_tp.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-public"
    Terraform   = "True"
    Description = "Subnet one"
  }
}
resource "aws_subnet" "subnet_public_two" {
  vpc_id                  = aws_vpc.vpc_tp.id
  cidr_block              = "172.16.2.0/24"
  availability_zone       = "us-east-1e"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-public-two"
    Terraform   = "True"
    Description = "Subnet two"
  }
}


resource "aws_internet_gateway" "gateway_tp" {
  vpc_id = aws_vpc.vpc_tp.id
  tags = {
    Name        = "tp-gateway"
    Terraform   = "True"
    Description = "Gateway for the web application"
  }
}

resource "aws_default_route_table" "defaultroutetable_tp" {
  default_route_table_id = aws_vpc.vpc_tp.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway_tp.id
  }
  tags = {
    Name        = "rt-tp"
    Terraform   = "True"
    Description = "Route Table for the tp"
  }
} 