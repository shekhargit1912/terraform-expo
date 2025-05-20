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

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS DB subnet group"
  type        = list(string)
  # No default, must be provided
}

variable "db_name" {
  description = "Name for the RDS database"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Username for the RDS database master user"
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "Password for the RDS database master user"
  type        = string
  sensitive   = true
  # No default, must be provided
}

variable "db_instance_class" {
  description = "Instance class for the RDS database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine" {
  description = "Database engine for the RDS instance (e.g., postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Version of the database engine"
  type        = string
  default     = "14.5" # User should verify this is a valid and supported version
}

variable "db_allocated_storage" {
  description = "Allocated storage for the RDS database in GB"
  type        = number
  default     = 20
}

variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be deployed"
  type        = string
  # No default, must be provided
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC for the RDS security group ingress rule"
  type        = string
  # No default, must be provided
}

variable "db_port" {
  description = "Port for the RDS database"
  type        = number
  default     = 5432
}
