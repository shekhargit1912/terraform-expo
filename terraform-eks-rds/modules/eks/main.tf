# --- IAM Role for EKS Cluster ---
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.cluster_name}-cluster-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# --- IAM Role for EKS Node Groups ---
resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.project_name}-${var.cluster_name}-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.cluster_name}-node-group-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" # Corrected policy name
  role       = aws_iam_role.eks_node_group_role.name
}

# --- EKS Cluster ---
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = var.private_subnet_ids # EKS control plane can be in private subnets
    vpc_id     = var.vpc_id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.cluster_name}"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
  ]
}

# --- EKS Node Group - Website ---
resource "aws_eks_node_group" "website_nodes" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-website-nodes"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = var.website_node_group_instance_types

  scaling_config {
    min_size     = var.website_node_group_min_size
    max_size     = var.website_node_group_max_size
    desired_size = var.website_node_group_desired_size
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.cluster_name}-website-nodes"
      NodeGroupType = "website"
    }
  )

  depends_on = [
    aws_eks_cluster.main,
    aws_iam_role_policy_attachment.eks_worker_node_policy_attachment,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
  ]
}

# --- EKS Node Group - Mobile ---
resource "aws_eks_node_group" "mobile_nodes" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-mobile-nodes"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = var.mobile_node_group_instance_types

  scaling_config {
    min_size     = var.mobile_node_group_min_size
    max_size     = var.mobile_node_group_max_size
    desired_size = var.mobile_node_group_desired_size
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.cluster_name}-mobile-nodes"
      NodeGroupType = "mobile"
    }
  )

  depends_on = [
    aws_eks_cluster.main,
    aws_iam_role_policy_attachment.eks_worker_node_policy_attachment,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
  ]
}
