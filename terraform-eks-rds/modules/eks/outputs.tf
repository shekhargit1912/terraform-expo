output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster's Kubernetes API server"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "The base64 encoded certificate data for the EKS cluster's Kubernetes API server"
  value       = aws_eks_cluster.main.certificate_authority[0].data
  sensitive   = true # This output contains sensitive information
}

output "website_node_group_arn" {
  description = "The ARN of the website EKS node group"
  value       = aws_eks_node_group.website_nodes.arn
}

output "mobile_node_group_arn" {
  description = "The ARN of the mobile EKS node group"
  value       = aws_eks_node_group.mobile_nodes.arn
}

output "eks_cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_group_role_arn" {
  description = "The ARN of the IAM role for the EKS node groups"
  value       = aws_iam_role.eks_node_group_role.arn
}
