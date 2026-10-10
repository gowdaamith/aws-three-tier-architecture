resource "aws_db_subnet_group" "this" {
  name = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = values(var.database_subnet_id)
 
  tags = {
    Name        = "${var.project_name}-${var.environment}-db-subnet-group"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_db_parameter_group" "this" {
  name = "${var.project_name}-${var.environment}-parameter-group"
  family = "postgres17"
  description = "custom postgres SQL parameter group"
  
  parameter {
    name = "log_connections"
    value = "1"
    apply_method = "immediate"
  }

  parameter {
    name = "log_disconnection"
    value = "1"
    apply_method = "immediate"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-postgres"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


resource "aws_db_instance" "this" {
  identifier ="${var.project_name}-${var.environment}-db"
  engine = "postgres"
  engine_version = "17"
  instance_class = var.instance_class
  allocated_storage =var.allocated_storage
  storage_type = "gp3"
  db_name = var.database_name
  username = var.master_username
  password= var.master_password
  
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.database_security_group_id]
  parameter_group_name = aws_db_parameter_group.this.name
  publicly_accessible  = false
  multi_az =var.multi_az
  backup_retention_period = var.backup_retention_period
  backup_window = "18:00-19:00"
  maintenance_window = "sun:19:00-sun:20:00"
  storage_encrypted = true
  auto_minor_version_upgrade = true
  deletion_protection = false
  skip_final_snapshot = true
  copy_tags_to_snapshot = true
 
  tags = {
    Name        = "${var.project_name}-${var.environment}-db"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


