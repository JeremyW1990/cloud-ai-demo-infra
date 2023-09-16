data "aws_eks_cluster" "cluster" {
  name = "cloud-ai-demo"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "cloud-ai-demo"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

module "eks_cluster" {
  source = "./modules/eks"

  vpc_id          = aws_vpc.cloud-ai-vpc.id
  private_subnets = [aws_subnet.cloud-ai-private-subnet-us-east-1a.id, aws_subnet.cloud-ai-private-subnet-us-east-1b.id, aws_subnet.cloud-ai-private-subnet-us-east-1c.id]
  cluster_version = "1.27"
  
  cluster_name = "cloud-ai-demo"
}

