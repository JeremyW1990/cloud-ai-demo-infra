locals {
  aws_auth_config = yamldecode(file("${path.module}/aws-auth-configmap.yaml"))
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

