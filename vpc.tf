resource "aws_vpc" "cloud-ai-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Cloud-AI VPC"
  }
}

# Now, all three subnets are public subnets.
resource "aws_subnet" "cloud-ai-public-subnet-us-east-1a" {
  vpc_id            = aws_vpc.cloud-ai-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true # This attribute is crucial for a public subnet

  tags = {
    Name = "Cloud-AI Public Subnet us-east-1a"
  }
}

resource "aws_subnet" "cloud-ai-public-subnet-us-east-1b" {
  vpc_id            = aws_vpc.cloud-ai-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Cloud-AI Public Subnet us-east-1b"
  }
}

resource "aws_subnet" "cloud-ai-public-subnet-us-east-1c" {
  vpc_id            = aws_vpc.cloud-ai-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Cloud-AI Public Subnet us-east-1c"
  }
}

resource "aws_security_group" "cloud-ai-allow-all" {
  name        = "cloud-ai-allow-all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.cloud-ai-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Cloud-AI Allow All"
  }
}

resource "aws_internet_gateway" "cloud-ai-igw" {
  vpc_id = aws_vpc.cloud-ai-vpc.id

  tags = {
    Name = "Cloud-AI Internet Gateway"
  }
}

# Route table for the now-public subnets
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.cloud-ai-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.cloud-ai-igw.id
  }

  tags = {
    Name = "Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "public-subnet-association-1a" {
  subnet_id      = aws_subnet.cloud-ai-public-subnet-us-east-1a.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-association-1b" {
  subnet_id      = aws_subnet.cloud-ai-public-subnet-us-east-1b.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-association-1c" {
  subnet_id      = aws_subnet.cloud-ai-public-subnet-us-east-1c.id
  route_table_id = aws_route_table.public-route-table.id
}
