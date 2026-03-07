variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "key_name" {
  type = string
}
variable "environment" {
  description = "Environment name"
  type        = string
}