resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.private_subnets
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
  ]
}

# resource "aws_eks_node_group" "this" {
#   cluster_name    = aws_eks_cluster.this.name
#   node_group_name = "cloud-ai-nodes"
#   node_role_arn   = aws_iam_role.eks_nodes.arn
#   subnet_ids = var.private_subnets

#   scaling_config {
#     desired_size = 3
#     min_size     = 2
#     max_size     = 3
#   }

#   depends_on = [ 
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#   ]
# }