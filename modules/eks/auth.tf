locals {
  aws_auth_config = yamldecode(file("${path.module}/aws-auth-configmap.yaml"))
}

# data "aws_eks_cluster_auth" "this" {
#   name = var.cluster_name
# }

# data "aws_eks_cluster" "this" {
#   name = var.cluster_name
# }

provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = aws_eks_cluster_auth.this.token
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth" 
    namespace = "kube-system"
  }

  data = {
    mapRoles = local.aws_auth_config["mapRoles"]
    mapUsers = local.aws_auth_config["mapUsers"]
  }
}

