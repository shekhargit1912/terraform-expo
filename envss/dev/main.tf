module "vpc" {
source = "../../modules/vpc"

vpc_cidr = local.vpc_cidr
cidr_private_subnet = local.cidr_private_subnet
cidr_public_subnet = local.cidr_public_subnet
us_availability_zone = local.availability_zone

}

module "ec2_instace" {
    source = "../../modules/ec2"
    ami_name = local.ami_name
    instance_size = local.instance_size
    public_subnet_id = module.vpc.public_subnet_id[1]
    
    
   
    
}

module "rds" {
    source = "../../modules/rds"
    db_name = local.db_name
    db_password = local.db_password 
    storage_type = local.storage_type
    para = local.para
    instance_class = local.instance_class
    allocated_storage = local.allocated_storage
    db_username = local.db_username
  
}

module "eks" {
    source = "../../modules/eks"
    eks_cluster_name = local.eks_cluster_name
    eks_version = local.eks_version
    iam_role_name = local.iam_role_name
    iam_role_name_node = local.iam_role_name_node
    instance_type = local.instance_type[0]
    disk_siz2 = local.disk_siz2
    public_subnet_id = module.vpc.public_subnet_id[1]
    priavte_subnet_id = module.vpc.priavte_subnet_id[0]
    
  
}

# resource "aws_route_table" "private_route_table" {
#   count      = length(var.cidr_private_subnet)
#   vpc_id = aws_vpc.vpc_mod.id
#   depends_on = [aws_nat_gateway.nat_gateway]
#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
#   }
#   tags = {
#     Name = "RT Pri"
#   }
# }
