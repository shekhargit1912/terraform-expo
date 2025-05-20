output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster's Kubernetes API server"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  description = "The name (ID) of the EKS cluster"
  value       = module.eks.eks_cluster_id # Using the cluster ID from the module output
}

output "rds_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_instance_address" {
  description = "The address of the RDS instance"
  value       = module.rds.db_instance_address
}

output "website_node_group_arn" {
  description = "The ARN of the EKS website node group"
  value       = module.eks.website_node_group_arn
}

output "mobile_node_group_arn" {
  description = "The ARN of the EKS mobile node group"
  value       = module.eks.mobile_node_group_arn
}

# Exposing some more useful outputs from the VPC module
output "public_subnet_ids" {
  description = "List of IDs of public subnets in the VPC"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets in the VPC"
  value       = module.vpc.private_subnet_ids
}

output "rds_db_name" {
  description = "The name of the RDS database"
  value       = module.rds.db_name
}
