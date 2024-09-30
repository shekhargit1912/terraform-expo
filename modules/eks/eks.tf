
resource "aws_iam_role" "demo" {
  name = var.iam_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {

policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
role = aws_iam_role.demo.name
  
}

resource "aws_eks_cluster" "eks" {
    name = var.eks_cluster_name
    role_arn = aws_iam_role.demo.arn
    version = var.eks_version

    vpc_config {
      subnet_ids = [var.priavte_subnet_id,var.public_subnet_id]

    }

    depends_on = [ aws_iam_role_policy_attachment.amazon_eks_cluster_policy  ]
  
}

resource "aws_iam_role" "demo_nodes" {
    name = var.iam_role_name_node

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {

policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
role = aws_iam_role.demo_nodes.name
  
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  role = aws_iam_role.demo_nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  role = aws_iam_role.demo_nodes.name
}

resource "aws_eks_node_group" "eks_node_gorup" {
    cluster_name = aws_eks_cluster.eks.name
    node_group_name = "eks-demo-node-group"
  
  node_role_arn = aws_iam_role.demo_nodes.arn
 subnet_ids = [var.priavte_subnet_id,var.public_subnet_id]

 instance_types = [ var.instance_type]

 disk_size = var.disk_siz2

   scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [ aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only ,
  aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
  aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  
   ]

}