
#################################
# VPC MODULE
#################################

module "vpc" {
  source = "./modules/vpc"

  aws_region  = var.aws_region
  environment = var.environment

  vpc_name = "${var.cluster_name}-vpc"
  vpc_cidr = "10.0.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24"
  ]

  enable_nat_gateway   = true
  enable_dns_hostnames = true
}

#################################
# IAM MODULE
#################################

module "iam" {
  source = "./modules/iam"

  cluster_name = var.cluster_name
}

#################################
# EKS CLUSTER MODULE
#################################

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  cluster_role_arn = module.iam.cluster_role_arn

  instance_type   = "t3.medium"
  key_name        = var.key_name
}

#################################
# NODE GROUP MODULE
#################################

module "nodegroups" {
  source = "./modules/nodegroups"

  cluster_name    =  var.cluster_name
  node_group_name = "eks-workers"

  private_subnets = module.vpc.private_subnets
  node_role_arn   = module.iam.node_role_arn

  instance_types  = ["t3.medium"]

  desired_size    = 1
  min_size        = 1
  max_size        = 2

  key_name        = var.key_name
  depends_on      = [module.eks]
}