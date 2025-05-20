variable "aws_region" {
  description = "AWS region for deploying resources"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Root project name for consistent tagging and naming"
  type        = string
  default     = "my-eks-rds-demo"
}

variable "common_tags" {
  description = "Common tags to apply to all resources created by the modules"
  type        = map(string)
  default = {
    Environment = "Dev"
    Project     = "MyEksRdsDemo"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets. Must match the number of availability_zones."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets. Must match the number of availability_zones."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets. Must match the number of public/private subnet CIDRs."
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "eks_cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
  default     = "main-cluster"
}

variable "eks_kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "rds_db_name" {
  description = "Name for the RDS database"
  type        = string
  default     = "appdb"
}

variable "rds_db_username" {
  description = "Username for the RDS database master user"
  type        = string
  default     = "dbadmin"
}

variable "rds_db_password" {
  description = "Password for the RDS database instance master user"
  type        = string
  sensitive   = true
  # No default, must be provided by the user
}

variable "rds_instance_class" {
  description = "Instance class for the RDS database"
  type        = string
  default     = "db.t3.micro"
}

# Variables for EKS node groups (optional, could rely on module defaults)
# Example:
# variable "website_node_group_instance_type" {
#   description = "Instance type for the EKS website node group"
#   type        = list(string)
#   default     = ["t3.medium"]
# }

# variable "website_node_group_desired_size" {
#   description = "Desired number of nodes for the website node group"
#   type        = number
#   default     = 2
# }
