terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  common_tags          = var.common_tags
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  common_tags        = var.common_tags
  cluster_name       = var.eks_cluster_name
  kubernetes_version = var.eks_kubernetes_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  # You can expose more EKS node group variables at the root level if needed
  # For example:
  # website_node_group_instance_types = var.website_node_group_instance_type
  # website_node_group_desired_size = var.website_node_group_desired_size
}

module "rds" {
  source = "./modules/rds"

  project_name    = var.project_name
  common_tags     = var.common_tags
  vpc_id          = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_cidr_block  = module.vpc.vpc_cidr_block # For RDS security group

  db_name           = var.rds_db_name
  db_username       = var.rds_db_username
  db_password       = var.rds_db_password
  db_instance_class = var.rds_instance_class
  # db_engine and db_engine_version will use module defaults unless overridden here
}
