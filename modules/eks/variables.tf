variable "public_subnet_id" {
    type = string
  
}

variable "priavte_subnet_id" {
    type = string
  
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM role for the EKS cluster."
  type        = string
}

variable "iam_role_name_node" {
    description = "name for the node"
    type = string
  
}

variable "eks_version" {
  description = "The version of the EKS cluster."
  type        = string
 
}


variable "disk_siz2" {
    description = "disck_size"
    
  
}

variable "instance_type" {
    description = "Instance_type"

}