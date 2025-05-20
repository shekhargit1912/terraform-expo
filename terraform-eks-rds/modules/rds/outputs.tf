output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.main.address
}

output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_port" {
  description = "The port on which the RDS instance is listening"
  value       = aws_db_instance.main.port
}

output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = aws_db_subnet_group.main.name
}

output "db_security_group_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.main.id
}

output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "The master username for the database"
  value       = aws_db_instance.main.username
}
