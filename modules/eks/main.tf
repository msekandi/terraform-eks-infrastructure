# -----------------------------
# Get Default VPC
# -----------------------------
data "aws_vpc" "default" {
  default = true
}

# -----------------------------
# Get Default Subnets
# -----------------------------
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# -----------------------------
# Latest Amazon Linux 2 AMI
# -----------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# -----------------------------
# Security Group
# -----------------------------
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-spot-sg"
  description = "Allow SSH and Jenkins"
  vpc_id      = var.vpc_id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# Spot Instances
# -----------------------------
resource "aws_instance" "spot_instances" {
  count = 2

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = element(
    var.private_subnets,count.index
  )

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  instance_market_options {
    market_type = "spot"

    spot_options {
      spot_instance_type = "one-time"
    }
  }

  tags = {
    Name = "jenkins-spot-${count.index}"
  }
}

#################################
# EKS CLUSTER
#################################

resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.private_subnets
  }

  depends_on = [
    var.cluster_role_arn
  ]

  tags = {
    Name = var.cluster_name
  }
}