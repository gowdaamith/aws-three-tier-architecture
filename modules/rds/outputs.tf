output "db_instance_id" {
  description = "the id of the database instnace created"
  value = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "the arn of the databse instance created"
  value = aws_db_instance.this.arn
}

output "db_endpoint" {
  description = "The endpoint of hte database created"
  value = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "The address of the database instance"
  value = aws_db_instance.this.address
}


output "db_port" {
  description = "The port of the database instnace"
  value = aws_db_instance.this.port
}


output "db_name" {
  description = "The name of the database instance created" 
  value = aws_db_instance.this.db_name
}
