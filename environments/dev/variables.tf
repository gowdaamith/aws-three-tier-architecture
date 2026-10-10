variable "aws_region" {
  description = "enter the region where you want to create the resources"
  type        = string
}

variable "project_name" {
  description = "enter the name fo the project"
  type        = string
}

variable "environment" {
  description = "enter the environments of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "enter the cidr range of the vpc"
  type        = string
}

variable "public_subnets" {
  description = "Enter the az and cidr range of the public subnet"
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "private_app_subnets" {
  description = "Enter the az and cidr range of the private app subnet"
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
}


variable "private_db_subnets" {
  description = "Enter the az and cidr range of the private db  subnet"
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "database_name" {
  description = "Application database name"
  type        = string
}

variable "master_username" {
  description = "RDS master username"
  type        = string
}

variable "master_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS storage size in GB"
  type        = number
}

variable "db_backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
}

variable "db_multi_az" {
  description = "Enable RDS Multi-AZ"
  type        = bool
}





