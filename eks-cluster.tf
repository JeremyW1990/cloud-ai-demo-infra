module "eks_cluster" {
  source = "./modules/eks"

  vpc_id          = aws_vpc.cloud-ai-vpc.id
  subnets = [aws_subnet.cloud-ai-public-subnet-us-east-1a.id, aws_subnet.cloud-ai-public-subnet-us-east-1b.id, aws_subnet.cloud-ai-public-subnet-us-east-1c.id]
  cluster_version = "1.27"
  
  cluster_name = "cloud-ai-demo"
}

