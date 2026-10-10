variable "project_name" {
  description = "Enter the name of the project"
  type = string
}

variable "environment"{
  description = "Enter the environment of the project"
  type = string
}

variable "database_subnet_id"{
  description = "map of database subnet identifiers used to create DB subnet group accross az"
  type = map(string)
}

variable "database_security_group_id" {
  description = "The id of the security group that controls"
  type = string
}

variable "database_name" {
  description = "Enter the initial db created to be created inside the rds db instance"
  type =string
}

variable "master_username" {
  description = "the master user name used to authenticated to the rds instance created"
  type = string
}

variable "master_password" {
  description = "the password used to authenticate to the rds instance"
  type = string
  sensitive =true
}

variable "instance_class"{
  description = "the instance class you want to for the database"
  type = string
}

variable "allocated_storage"{ 
  description = "the initial amount of storage allocated to the rds "
  type = string
}

variable "backup_retention_period" {
  description = "the amomunt of days to keep the backup for "
  type = number
}

variable "multi_az"{
  description = "wheather to enable the multi_az deployment for high availability and failover or not"
  type = bool
}


