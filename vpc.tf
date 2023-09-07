resource "aws_vpc" "cloud-ai-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Cloud-AI VPC" 
  }
}

resource "aws_subnet" "cloud-ai-private-subnet-us-east-1a" {
  vpc_id            = aws_vpc.cloud-ai-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Cloud-AI Private Subnet us-east-1a"
  }
}

resource "aws_subnet" "cloud-ai-private-subnet-us-east-1b" {
  vpc_id            = aws_vpc.cloud-ai-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Cloud-AI Private Subnet us-east-1b"
  }
}

resource "aws_subnet" "cloud-ai-private-subnet-us-east-1c" {
  vpc_id            = aws_vpc.cloud-ai-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Cloud-AI Private Subnet us-east-1c"
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