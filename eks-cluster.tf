

module "eks_cluster" {
  source = "./modules/eks"

  vpc_id          = aws_vpc.cloud-ai-vpc.vpc_id
  private_subnets = aws_vpc.cloud-ai-vpc.private_subnets
  cluster_version = "1.27"
  
  cluster_name = "my-cluster"
}