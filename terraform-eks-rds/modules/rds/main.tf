# --- DB Subnet Group ---
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-rds-subnet-group"
    }
  )
}

# --- RDS Security Group ---
resource "aws_security_group" "main" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow DB port access from VPC"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    cidr_blocks     = [var.vpc_cidr_block] # Allows access from anywhere in the VPC
    # For more restrictive access, you would use security_groups = [eks_cluster_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-rds-sg"
    }
  )
}

# --- RDS Instance ---
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-rds-instance"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.main.id]

  publicly_accessible    = false
  skip_final_snapshot    = true # Set to false for production

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-rds-instance"
    }
  )
}
