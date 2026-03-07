variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_group_name" {
  description = "Node group name"
  type        = string
}

variable "instance_types" {
  description = "Instance types for nodes"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
}

variable "key_name" {
  description = "SSH key for EC2 nodes"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role for EKS worker nodes"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs"
  type        = list(string)
}