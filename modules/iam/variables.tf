variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "enable_irsa" {
  description = "Enable IAM roles for service accounts"
  type        = bool
  default     = true
}