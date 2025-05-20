variable "cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "project_name" {
  description = "Name of the project for tagging consistency"
  type        = string
  default     = "eks-rds-project"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed"
  type        = string
  # No default, must be provided
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS node groups"
  type        = list(string)
  # No default, must be provided
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "website_node_group_instance_types" {
  description = "Instance types for the website node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "website_node_group_min_size" {
  description = "Minimum number of nodes for the website node group"
  type        = number
  default     = 1
}

variable "website_node_group_max_size" {
  description = "Maximum number of nodes for the website node group"
  type        = number
  default     = 3
}

variable "website_node_group_desired_size" {
  description = "Desired number of nodes for the website node group"
  type        = number
  default     = 2
}

variable "mobile_node_group_instance_types" {
  description = "Instance types for the mobile node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "mobile_node_group_min_size" {
  description = "Minimum number of nodes for the mobile node group"
  type        = number
  default     = 1
}

variable "mobile_node_group_max_size" {
  description = "Maximum number of nodes for the mobile node group"
  type        = number
  default     = 2
}

variable "mobile_node_group_desired_size" {
  description = "Desired number of nodes for the mobile node group"
  type        = number
  default     = 1
}
