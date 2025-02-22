####################################
# Create a VPC
####################################

resource "aws_vpc" "my_vpc" {

  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = var.vpc_name
  }

}

####################################
# Create a IGW
####################################

resource "aws_internet_gateway" "my_igw" {

  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.my_igw_name
  }

}

####################################
# Create a public subnets
####################################

resource "aws_subnet" "my_pub_sub_1" {

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pub_sub_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.pub_subnet_name_1
  }

}

resource "aws_subnet" "my_pub_sub_2" {

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pub_sub_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.pub_subnet_name_2
  }

}

####################################
# Create a private subnets
####################################

resource "aws_subnet" "my_pvt_sub_1" {

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pvt_sub_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = var.pvt_subnet_name_1
  }

}

resource "aws_subnet" "my_pvt_sub_2" {

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pvt_sub_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = var.pvt_subnet_name_2
  }

}

####################################
# Create a route table
####################################

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.public_route_table_name
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

####################################
# Database route table
####################################

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.database_route_table_name
  }
}

####################################
# Associate routes
####################################

resource "aws_route_table_association" "public_route_table_association_1" {

  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.my_pub_sub_1.id

}

resource "aws_route_table_association" "public_route_table_association_2" {

  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.my_pub_sub_2.id

}

resource "aws_route_table_association" "private_route_table_association_1" {

  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.my_pvt_sub_1.id

}

resource "aws_route_table_association" "private_route_table_association_2" {

  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.my_pvt_sub_2.id

}

####################################
# Associate routes
####################################

resource "aws_security_group" "sg" {
  name        = "vi_sg"
  description = "Allow all inbound/outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress = [
    {
      description      = "All traffic"
      from_port        = 0    # All ports
      to_port          = 0    # All Ports
      protocol         = "-1" # All traffic
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      description      = "Outbound rule"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "vi_sg"
  }
}