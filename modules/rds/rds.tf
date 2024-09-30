resource "aws_db_instance" "this" {

  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = "mysql"
  engine_version       = "8.0" 
  instance_class       = var.instance_class
  db_name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.para 


}
