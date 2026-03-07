resource "aws_eks_node_group" "production" {
  cluster_name    = var.cluster_name
  node_group_name = "production-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"

  labels = {
    workload = "production"
  }
}

resource "aws_eks_node_group" "spot" {
  cluster_name    = var.cluster_name
  node_group_name = "spot-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"
}