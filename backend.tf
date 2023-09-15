provider "aws" {
  version = "~> 3.0"
}

provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
}

terraform {
  backend "s3" {
    bucket = "cloud-ai-demo-infra"
    key    = "cloud-ai/terraform.tfstate"
    region = "us-east-1"
  }
}