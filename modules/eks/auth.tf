

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
    - rolearn: arn:aws:iam::488770167024:role/eks-node-group-role
    username: system:node:{{EC2PrivateDNSName}}
    groups:
        - system:bootstrappers
        - system:nodes
    YAML
    # Optionally, if you want to add users to the config map:
    mapUsers = <<YAML
    - userarn: arn:aws:iam::488770167024:user/jeremywang
      username: jeremywang
      groups:
        - system:masters
    YAML
  }
}
