locals {
  vpc_cidr = "10.0.0.0/16"
cidr_public_subnet = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone = ["us-east-1a", "us-east-1b"]
}
locals {
  ami_name ="ami-0e86e20dae9224db8"
  instance_size ="t2.micro"
  
}

locals {
  allocated_storage ="10"
  db_name = "mysql"
  db_username = "shekhar"
  db_password = "SSWSDAS@23"
  instance_class ="db.t3.micros"
  storage_type = "gp3"
  para = "default.mysql8.0"
    
}

locals {
  eks_cluster_name = "eks"
  iam_role_name = "demo"
  eks_version = "1.29"
  iam_role_name_node = "node_group"
  disk_siz2 = "20"
  instance_type = ["t3.micro","t3.micro"]
}



variable "project_id" {
  type        = string
  description = "The"
  default = "dev"
}

