# Main VPC

resource "aws_vpc" "Project-5-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Project-5-VPC"
  }
}

# Public Subnet 1

resource "aws_subnet" "Project-5-Public-Subnet-1" {
  vpc_id     = aws_vpc.Project-5-VPC.id
  cidr_block = "10.0.20.0/24"

  tags = {
    Name = "Project-5-Public-Subnet-1"
  }
}

# Public Subnet 2

resource "aws_subnet" "Project-5-Public-Subnet-2" {
  vpc_id     = aws_vpc.Project-5-VPC.id
  cidr_block = "10.0.21.0/24"

  tags = {
    Name = "Project-5-Public-Subnet-2"
  }
}

# Private Subnet 1

resource "aws_subnet" "Project-5-Private-Subnet-1" {
  vpc_id     = aws_vpc.Project-5-VPC.id
  cidr_block = "10.0.22.0/24"

  tags = {
    Name = "Project-5-Private-Subnet-1"
  }
}

# Private Subnet 2

resource "aws_subnet" "Project-5-Private-Subnet-2" {
  vpc_id     = aws_vpc.Project-5-VPC.id
  cidr_block = "10.0.23.0/24"

  tags = {
    Name = "Project-5-Private-Subnet-2"
  }
}

# Public Route Table

resource "aws_route_table" "Project-5-Public-Route-Table" {
  vpc_id = aws_vpc.Project-5-VPC.id



  tags = {
    Name = "Project-5-Public-Route-Table"
  }
}

# Private Route Table

resource "aws_route_table" "Project-5-Private-Route-Table" {
  vpc_id = aws_vpc.Project-5-VPC.id


  tags = {
    Name = "Project-5-Private-Route-Table"
  }
}

# Association of Public Subnet 1 with Public Route Table

resource "aws_route_table_association" "Project-5-Public-Subnet-1-Association-With-RT" {
  subnet_id      = aws_subnet.Project-5-Public-Subnet-1.id
  route_table_id = aws_route_table.Project-5-Public-Route-Table.id
}

# Association of Public Subnet 2 with Public Route Table

resource "aws_route_table_association" "Project-5-Public-Subnet-2-Association-With-RT" {
  subnet_id      = aws_subnet.Project-5-Public-Subnet-2.id
  route_table_id = aws_route_table.Project-5-Public-Route-Table.id
}

# Association of Private Subnet 1 with Private Route Table

resource "aws_route_table_association" "Project-5-Private-Subnet-1-Association-With-RT" {
  subnet_id      = aws_subnet.Project-5-Private-Subnet-1.id
  route_table_id = aws_route_table.Project-5-Private-Route-Table.id
}

# Association of Private Subnet 2 with Private Route Table

resource "aws_route_table_association" "Project-5-Private-Subnet-2-Association-With-RT" {
  subnet_id      = aws_subnet.Project-5-Private-Subnet-2.id
  route_table_id = aws_route_table.Project-5-Private-Route-Table.id
}

# Internet Gateway

resource "aws_internet_gateway" "Project-5-IGW" {
  vpc_id = aws_vpc.Project-5-VPC.id

  tags = {
    Name = "Project-5-VPC"
  }
}

# Internet Gateway Association with Public Route Table

resource "aws_route" "IGW-Assoc-With-Pub-RT" {
  route_table_id            = aws_route_table.Project-5-Public-Route-Table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Project-5-IGW.id
}

# Nat Gateway Association with Private Route
resource "aws_nat_gateway" "Project-5-Private-Subnet-1" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.Project-5-Private-Subnet-1.id
}

# Nat Gateway Association with Private Route
resource "aws_nat_gateway" "Project-5-Private-Subnet-2" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.Project-5-Private-Subnet-2.id
  }
