variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS will run"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs for EKS"
  type        = list(string)
}

variable "cluster_endpoint_public_access" {
  description = "Allow public access to EKS API"
  type        = bool
  default     = true
}

variable "cluster_endpoint_private_access" {
  description = "Allow private access to EKS API"
  type        = bool
  default     = true
}
variable "instance_type" {
  description = "Instance type for EKS nodes"
  type        = string
}

variable "key_name" {
  description = "SSH key pair for EC2 nodes"
  type        = string
}
variable "cluster_role_arn" {
  type = string
}