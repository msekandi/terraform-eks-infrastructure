#################################
# Jenkins Instance IPs
#################################

output "instance_public_ips" {
  description = "Public IPs of Jenkins Spot instances"
  value       = aws_instance.spot_instances[*].public_ip
}
output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.eks.name
}